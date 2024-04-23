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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDiGJ3Oz-YSZ7KezwQgQHg74snnobauY_E',
    appId: '1:1033032582858:web:4964c4b5884e90987e9633',
    messagingSenderId: '1033032582858',
    projectId: 'trendtrading-4b591',
    authDomain: 'trendtrading-4b591.firebaseapp.com',
    storageBucket: 'trendtrading-4b591.appspot.com',
    measurementId: 'G-K2T3REKCZ5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKwSR3qYfxosmeoCnty6AKumXzZcHCMgA',
    appId: '1:1033032582858:android:be563f681d4f9da17e9633',
    messagingSenderId: '1033032582858',
    projectId: 'trendtrading-4b591',
    storageBucket: 'trendtrading-4b591.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIG6Jw0fPwSiB4OGjzuAxOYDqpn_vK_8Q',
    appId: '1:1033032582858:ios:f591d42f6389301d7e9633',
    messagingSenderId: '1033032582858',
    projectId: 'trendtrading-4b591',
    storageBucket: 'trendtrading-4b591.appspot.com',
    iosBundleId: 'com.example.trendTrading',
  );
}