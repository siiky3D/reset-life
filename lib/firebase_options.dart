// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDLkQL6HDwobWg7aml6vqTTKFv4LFeMaVg',
    appId: '1:369011696004:web:787ff9b38ddce53cd67dd1',
    messagingSenderId: '369011696004',
    projectId: 'resetlife-dev',
    authDomain: 'resetlife-dev.firebaseapp.com',
    storageBucket: 'resetlife-dev.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDofw-e0FVh0BApgVroBgP-LjT7ghRPiME',
    appId: '1:369011696004:android:d8aaba22184cb0e0d67dd1',
    messagingSenderId: '369011696004',
    projectId: 'resetlife-dev',
    storageBucket: 'resetlife-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAX4Acu7gEdMeDpPTdLVJKNcK9LOnq9uQM',
    appId: '1:369011696004:ios:a3b51ab2b221b060d67dd1',
    messagingSenderId: '369011696004',
    projectId: 'resetlife-dev',
    storageBucket: 'resetlife-dev.firebasestorage.app',
    iosBundleId: 'com.custom.org.my-app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAX4Acu7gEdMeDpPTdLVJKNcK9LOnq9uQM',
    appId: '1:369011696004:ios:147c1c9c7a1ed3a6d67dd1',
    messagingSenderId: '369011696004',
    projectId: 'resetlife-dev',
    storageBucket: 'resetlife-dev.firebasestorage.app',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDLkQL6HDwobWg7aml6vqTTKFv4LFeMaVg',
    appId: '1:369011696004:web:357feb76dd61b354d67dd1',
    messagingSenderId: '369011696004',
    projectId: 'resetlife-dev',
    authDomain: 'resetlife-dev.firebaseapp.com',
    storageBucket: 'resetlife-dev.firebasestorage.app',
  );
}
