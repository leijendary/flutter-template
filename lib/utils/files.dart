import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class Files {
  static Future<File> createTempFile({String? fileName}) async {
    fileName ??= UUID.getUUID();
    final directory = await path_provider.getTemporaryDirectory();
    final localPath = path.join(directory.path, fileName);

    return File(localPath);
  }
}
