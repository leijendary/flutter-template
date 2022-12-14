import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:template/utils/files.dart';

final fileApiProvider = Provider((_) => FileApi());

class FileApi {
  Future<File> download(String uri) async {
    final response = await http.get(Uri.parse(uri));
    final fileName = path.basename(uri);
    final file = await Files.createTempFile(fileName: fileName);
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
