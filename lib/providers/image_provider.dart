import 'package:flutter_sample/utils/storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageUrlProvider = FutureProvider.family.autoDispose<String, String>(
  (_, key) async => Storage.getUrl(key),
);
