import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/amplifyconfiguration.dart';
import 'package:flutter_sample/firebase_options.dart';
import 'package:flutter_sample/models/ModelProvider.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> firebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

Future<void> amplify() async {
  final auth = AmplifyAuthCognito();
  final api = AmplifyAPI(modelProvider: ModelProvider.instance);
  final storage = AmplifyStorageS3();
  await Amplify.addPlugins([auth, api, storage]);
  await Amplify.configure(amplifyconfig);
}

Future<void> database() async {
  await Hive.initFlutter();

  for (var box in Boxes.all) {
    await Hive.openBox(box);
  }
}

Future<void> session() async {
  final container = ProviderContainer();

  await container.read(sessionProvider.notifier).initialize();
}
