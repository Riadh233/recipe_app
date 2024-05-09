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
    apiKey: 'AIzaSyCbUOspd_ZPKK4fQCd07WdM3vc7iL669as',
    appId: '1:809130598691:web:c1615e22b8320225c3ac96',
    messagingSenderId: '809130598691',
    projectId: 'recipes-app-bd880',
    authDomain: 'recipes-app-bd880.firebaseapp.com',
    storageBucket: 'recipes-app-bd880.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_G9rg3413QULZ7Kn443Sr5Hb2t-C4PKU',
    appId: '1:809130598691:android:fb07f1c7949a5aa1c3ac96',
    messagingSenderId: '809130598691',
    projectId: 'recipes-app-bd880',
    storageBucket: 'recipes-app-bd880.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEmq-1FudD9ODY8ru32gzHtvlygLBq0zM',
    appId: '1:809130598691:ios:284a5d62cfc9c236c3ac96',
    messagingSenderId: '809130598691',
    projectId: 'recipes-app-bd880',
    storageBucket: 'recipes-app-bd880.appspot.com',
    iosClientId: '809130598691-eoip6vsta6je9frt7n2t4d7adm84s54m.apps.googleusercontent.com',
    iosBundleId: 'com.example.recipeApp',
  );
}