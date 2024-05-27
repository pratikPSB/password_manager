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
    apiKey: 'AIzaSyA_8H3w5NM1GZCp0_Q6TPxnmKEC_NN68jw',
    appId: '1:521580404567:web:3cdf30f1997ff95e322812',
    messagingSenderId: '521580404567',
    projectId: 'password-manager-f0384',
    authDomain: 'password-manager-f0384.firebaseapp.com',
    storageBucket: 'password-manager-f0384.appspot.com',
    measurementId: 'G-S1TFX1LK7B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3Lhd52skt_B95H6G7CArE025DXwutMNo',
    appId: '1:521580404567:android:a4c2c19130880b01322812',
    messagingSenderId: '521580404567',
    projectId: 'password-manager-f0384',
    storageBucket: 'password-manager-f0384.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA322-kGlbzn0jAEr-c5rifhDrkMjL-GE4',
    appId: '1:521580404567:ios:fa5ef761e153015d322812',
    messagingSenderId: '521580404567',
    projectId: 'password-manager-f0384',
    storageBucket: 'password-manager-f0384.appspot.com',
    iosBundleId: 'com.psb.passwordManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA322-kGlbzn0jAEr-c5rifhDrkMjL-GE4',
    appId: '1:521580404567:ios:fa5ef761e153015d322812',
    messagingSenderId: '521580404567',
    projectId: 'password-manager-f0384',
    storageBucket: 'password-manager-f0384.appspot.com',
    iosBundleId: 'com.psb.passwordManager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA_8H3w5NM1GZCp0_Q6TPxnmKEC_NN68jw',
    appId: '1:521580404567:web:b45326973a00de94322812',
    messagingSenderId: '521580404567',
    projectId: 'password-manager-f0384',
    authDomain: 'password-manager-f0384.firebaseapp.com',
    storageBucket: 'password-manager-f0384.appspot.com',
    measurementId: 'G-0HNYBWB81P',
  );
}