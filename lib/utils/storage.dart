import 'package:amplify_flutter/amplify_flutter.dart';

class Storage {
  static Future<String> getUrl(String key) async {
    final result = await Amplify.Storage.getUrl(
      key: key,
      options: GetUrlOptions(
        // Set expiration to 7 days
        expires: 604800,
      ),
    );

    return result.url;
  }
}
