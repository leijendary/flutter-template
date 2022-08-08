import 'dart:async';
import 'dart:io';

import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_sample/apis/file_api.dart';
import 'package:flutter_sample/apis/menu_api.dart';
import 'package:flutter_sample/errors/graphql_exception.dart';
import 'package:flutter_sample/models/ModelProvider.dart';
import 'package:flutter_sample/utils/files.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

final menuRepositoryProvider = Provider((ref) {
  final menuApi = ref.read(menuApiProvider);
  final fileApi = ref.read(fileApiProvider);

  return MenuRepository(menuApi, fileApi);
});

class MenuRepository {
  MenuRepository(
    this._menuApi,
    this._fileApi,
  );

  final MenuApi _menuApi;
  final FileApi _fileApi;
  final _dateTimeFormat = DateFormat("yyyyMMddHms");

  Future<String?> refill(String? currentETag) async {
    final apiETag = await _menuApi.eTag();

    if (currentETag != null && apiETag == currentETag) {
      return apiETag;
    }

    final menus = await _menuApi.all();

    for (var i = 0; i < menus.length; i++) {
      var menu = menus[i];

      await _addMenus(
        menu: menu,
        index: i,
      );
    }

    return apiETag;
  }

  Future<PaginatedResult<Menu>> list() async {
    const listMenusSortedByOrdinal = "listMenusSortedByOrdinal";
    const query = """
      query (\$typeName: String!) {
        $listMenusSortedByOrdinal(typeName: \$typeName) {
          items {
            id
            name
            ordinal
            products {
              items {
                id
                name
                availability
                sizes
                asset {
                  full {
                    uri
                  }
                  master {
                    uri
                  }
                  thumbnail {
                    uri
                  }
                }
              }
            }
          }
        }
      }
    """;
    final request = GraphQLRequest<PaginatedResult<Menu>>(
      document: query,
      modelType: const PaginatedModelType(Menu.classType),
      variables: <String, dynamic>{
        "typeName": Menu.schema.name,
      },
      decodePath: listMenusSortedByOrdinal,
      apiName: "sample",
    );
    final response = await Amplify.API.query(request: request).response;

    if (response.errors.isNotEmpty) {
      throw GraphQLResponseException(response.errors);
    }

    return response.data!;
  }

  Future<GraphQLResponse<Menu>> create(Menu menu) async {
    final mutation = ModelMutations.create(menu);
    final request = GraphQLRequest<Menu>(
      document: mutation.document,
      decodePath: mutation.decodePath,
      modelType: mutation.modelType,
      variables: mutation.variables,
      apiName: "sample_cognito",
    );

    return await Amplify.API.mutate(request: request).response;
  }

  Future<GraphQLResponse<Product>> createProduct(
    Menu menu,
    Product product,
  ) async {
    product = product.copyWith(menu: menu);

    final mutation = ModelMutations.create(product);
    final request = GraphQLRequest<Product>(
      document: mutation.document,
      decodePath: mutation.decodePath,
      modelType: mutation.modelType,
      variables: mutation.variables,
      apiName: "sample_cognito",
    );

    return await Amplify.API.mutate(request: request).response;
  }

  Future<void> _addMenus({
    required Menu menu,
    required int index,
    String? parentId,
  }) async {
    final result = await create(menu);

    if (result.errors.isNotEmpty) {
      final exception = Exception(result.errors);

      FirebaseCrashlytics.instance.recordError(exception, null);
    }

    for (var i = 0; i < menu.children.length; i++) {
      final child = menu.children[i];

      await _addMenus(
        menu: child,
        parentId: menu.id,
        index: i,
      );
      await _addProducts(
        menu: child,
        index: i,
      );
    }
  }

  Future<void> _addProducts({
    required Menu menu,
    required int index,
  }) async {
    for (var i = 0; i < menu.products.length; i++) {
      var product = menu.products[i];
      final asset = await _uploadAsset(product.asset);
      product = product.copyWith(asset: asset);

      final result = await createProduct(menu, product);

      if (result.errors.isNotEmpty) {
        final exception = Exception(result.errors);

        FirebaseCrashlytics.instance.recordError(exception, null);
      }
    }
  }

  Future<ProductAsset> _uploadAsset(ProductAsset productAsset) async {
    final thumbnail = _uploadToS3(productAsset.thumbnail);
    final full = _uploadToS3(productAsset.full);
    final master = _uploadToS3(productAsset.master);
    final uploaded = await Future.wait([thumbnail, full, master]);

    return productAsset.copyWith(
      thumbnail: uploaded[0],
      full: uploaded[1],
      master: uploaded[2],
    );
  }

  Future<ProductAssetUri> _uploadToS3(ProductAssetUri productAssetUri) async {
    if (productAssetUri.uri == null) {
      return productAssetUri;
    }

    var uri = productAssetUri.uri!;
    File? originalFile;
    File? compressedFile;

    try {
      originalFile = await _fileApi.download(uri);
      compressedFile = await _compress(originalFile);

      final extension = path.extension(uri);
      final options = UploadFileOptions(accessLevel: StorageAccessLevel.guest);
      final date = _dateTimeFormat.format(DateTime.now());
      final uuid = UUID.getUUID().replaceAll("-", "");
      final hash = compressedFile.hashCode;
      final fileName = "${date}_${uuid}_$hash$extension";
      final result = await Amplify.Storage.uploadFile(
        local: compressedFile!,
        key: "products/$fileName",
        options: options,
      );

      uri = result.key;
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
    } finally {
      try {
        if (originalFile != null) {
          await originalFile.delete();
        }
      } catch (e, stack) {
        FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      }

      try {
        if (compressedFile != null) {
          await compressedFile.delete();
        }
      } catch (e, stack) {
        FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
      }
    }

    return productAssetUri.copyWith(uri: uri);
  }

  Future<File?> _compress(File file) async {
    final noExtension = path.withoutExtension(file.path);
    final fileName = path.basename(noExtension);
    final uuid = UUID.getUUID().replaceAll("-", "replace");
    final extension = path.extension(file.path);
    final tempFileName = "${fileName}_${uuid}_compressed$extension";
    final tempFile = await Files.createTempFile(fileName: tempFileName);

    return await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      tempFile.absolute.path,
      quality: 0,
    );
  }
}
