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
    apiKey: 'AIzaSyDHKARr3X4VZcGS7axxyCsNZFeeW9CA3hA',
    appId: '1:612114844525:web:3a65f3c0dbb142f47c6864',
    messagingSenderId: '612114844525',
    projectId: 'road-repair-service',
    authDomain: 'road-repair-service.firebaseapp.com',
    storageBucket: 'road-repair-service.appspot.com',
    measurementId: 'G-VV96HK6CN8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADS7EzzgC2aNPNK95reBdR6tglMVVDTDo',
    appId: '1:612114844525:android:91239cca67c0ad8e7c6864',
    messagingSenderId: '612114844525',
    projectId: 'road-repair-service',
    storageBucket: 'road-repair-service.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0pErJUeTfFYcurfxfc2CX-Zjpt6n-x0o',
    appId: '1:612114844525:ios:48a088b0a75484bf7c6864',
    messagingSenderId: '612114844525',
    projectId: 'road-repair-service',
    storageBucket: 'road-repair-service.appspot.com',
    iosBundleId: 'com.example.roadservicerepair',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0pErJUeTfFYcurfxfc2CX-Zjpt6n-x0o',
    appId: '1:612114844525:ios:48a088b0a75484bf7c6864',
    messagingSenderId: '612114844525',
    projectId: 'road-repair-service',
    storageBucket: 'road-repair-service.appspot.com',
    iosBundleId: 'com.example.roadservicerepair',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHKARr3X4VZcGS7axxyCsNZFeeW9CA3hA',
    appId: '1:612114844525:web:3a65f3c0dbb142f47c6864',
    messagingSenderId: '612114844525',
    projectId: 'road-repair-service',
    authDomain: 'road-repair-service.firebaseapp.com',
    storageBucket: 'road-repair-service.appspot.com',
    measurementId: 'G-VV96HK6CN8',
  );

}