import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/amplifyconfiguration.dart';
import 'package:flutter_sample/firebase_options.dart';
import 'package:flutter_sample/models/ModelProvider.dart';
import 'package:flutter_sample/repositories/etag_repository.dart';
import 'package:flutter_sample/repositories/menu_repository.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hive_flutter/adapters.dart';

late final BoxCollection collection;

Future<void> firebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

Future<void> amplify() async {
  final auth = AmplifyAuthCognito();
  final api = AmplifyAPI(modelProvider: ModelProvider.instance);
  await Amplify.addPlugins([auth, api]);
  await Amplify.configure(amplifyconfig);
}

Future<void> database() async {
  await Hive.initFlutter();

  for (var box in Boxes.all) {
    await Hive.openBox(box);
  }

  final eTagRepository = ETagRepository();
  final menuRepository = MenuRepository();
  final eTag = await eTagRepository.getMenuETag();
  final apiETag = await menuRepository.refill(eTag?.value);

  if (eTag?.value != apiETag) {
    // Reuse the old ETag object if any
    eTagRepository.setMenuETag(eTag, apiETag);
  }
}
