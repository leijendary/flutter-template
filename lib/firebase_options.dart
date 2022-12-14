// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMx7HPAd0np8Scxj6IoaP7kxgMSBxkq9E',
    appId: '1:293600011807:android:cd09e6deebbf6b3c9b172a',
    messagingSenderId: '293600011807',
    projectId: 'sample-1f232',
    storageBucket: 'sample-1f232.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxavdTbMR7RsBQ8tnKDS07iK_2eWTQtl4',
    appId: '1:293600011807:ios:74f422b6d0c8a9c19b172a',
    messagingSenderId: '293600011807',
    projectId: 'sample-1f232',
    storageBucket: 'sample-1f232.appspot.com',
    androidClientId:
        '293600011807-esu3hmgbejnt3ho8rtgiecdt2tp4re2h.apps.googleusercontent.com',
    iosClientId:
        '293600011807-s454h79onn8n3f27ik2libeuc1dlnv3t.apps.googleusercontent.com',
    iosBundleId: 'com.leijendary.flutter.flutterSample',
  );
}
