import 'package:flutter_sample/utils/storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageUrlProvider = FutureProvider.family.autoDispose<String, String>(
  (ref, key) async {
    final storage = ref.read(storageProvider);

    return await storage.getUrl(key);
  },
);
