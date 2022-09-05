import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/utils/storage.dart';

final imageUrlProvider = FutureProvider.family.autoDispose<String, String>(
  (ref, key) async {
    final storage = ref.read(storageProvider);

    return await storage.getUrl(key);
  },
);
