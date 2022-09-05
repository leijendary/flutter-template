import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/databases/cache_database.dart';
import 'package:template/utils/constants.dart';

final storageProvider = Provider((ref) {
  final cacheDatabase = ref.read(cacheDatabaseProvider);

  return Storage(cacheDatabase);
});

class Storage {
  Storage(this._cacheDatabase);

  final CacheDatabase _cacheDatabase;

  Future<String> getUrl(String key) async {
    final dbKey = "${Prefixes.storage}$key";
    final cache = await _cacheDatabase.get(dbKey);

    if (cache != null) {
      return cache["url"];
    }

    final result = await Amplify.Storage.getUrl(
      key: key,
      options: GetUrlOptions(
        expires: Configs.cacheExpires,
      ),
    );
    final url = result.url;
    final json = {
      "url": url,
    };

    await _cacheDatabase.put(
      key: dbKey,
      json: json,
      expires: Configs.cacheExpires,
    );

    return url;
  }
}
