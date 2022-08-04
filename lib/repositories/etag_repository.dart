import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter_sample/models/ModelProvider.dart';

class ETagRepository {
  Future<ETag?> getMenuETag() async {
    return getETag(Menu.schema.name);
  }

  Future<void> setMenuETag(ETag? eTag, String? value) async {
    return setETag(eTag, Menu.schema.name, value);
  }

  Future<void> setETag(ETag? eTag, String name, String? value) async {
    GraphQLRequest<ETag> mutation;

    if (eTag != null) {
      eTag = eTag.copyWith(value: value);
      mutation = ModelMutations.update(eTag);
    } else {
      // Reuse the old ETag object if any
      eTag = ETag(
        name: name,
        value: value,
      );
      mutation = ModelMutations.create(eTag);
    }

    final request = GraphQLRequest<ETag>(
      document: mutation.document,
      decodePath: mutation.decodePath,
      modelType: mutation.modelType,
      variables: mutation.variables,
      apiName: "sample_cognito",
    );

    await Amplify.API.mutate(request: request).response;
  }

  Future<ETag?> getETag(String name) async {
    const getETagByName = "getETagByName";
    const query = """
      query (\$name: String!) {
        $getETagByName(name: \$name) {
          items {
            id
            name
            value
          }
        }
      }
    """;
    final request = GraphQLRequest<PaginatedResult<ETag>>(
      document: query,
      modelType: const PaginatedModelType(ETag.classType),
      variables: <String, dynamic>{
        "name": name,
      },
      decodePath: getETagByName,
      apiName: "sample_cognito",
    );
    final response = await Amplify.API.query(request: request).response;

    return response.data?.items.firstOrNull;
  }
}
