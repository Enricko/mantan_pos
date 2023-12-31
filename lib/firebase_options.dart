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
        return macos;
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
    apiKey: 'AIzaSyDOZm35cD-x3Rs6CsafgeJTEP_KfVN_LA4',
    appId: '1:467529108341:web:e1d2e57a16a3eda421e13c',
    messagingSenderId: '467529108341',
    projectId: 'mantan-pos-e731d',
    authDomain: 'mantan-pos-e731d.firebaseapp.com',
    databaseURL: 'https://mantan-pos-e731d-default-rtdb.firebaseio.com',
    storageBucket: 'mantan-pos-e731d.appspot.com',
    measurementId: 'G-C0F2JX3XTN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5fs4vQBtrgSKVSmSWTwWhU-OhCvflxpM',
    appId: '1:467529108341:android:fb49c3a0ea63e1c021e13c',
    messagingSenderId: '467529108341',
    projectId: 'mantan-pos-e731d',
    databaseURL: 'https://mantan-pos-e731d-default-rtdb.firebaseio.com',
    storageBucket: 'mantan-pos-e731d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxx-SRWmfPJOepOk75KARzAizWaV9yuKU',
    appId: '1:467529108341:ios:49e127c582c840c121e13c',
    messagingSenderId: '467529108341',
    projectId: 'mantan-pos-e731d',
    databaseURL: 'https://mantan-pos-e731d-default-rtdb.firebaseio.com',
    storageBucket: 'mantan-pos-e731d.appspot.com',
    iosClientId: '467529108341-67mq5sevf7inkgipc8jo5avp0qnop75n.apps.googleusercontent.com',
    iosBundleId: 'com.example.mantanPos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxx-SRWmfPJOepOk75KARzAizWaV9yuKU',
    appId: '1:467529108341:ios:5528879724c4a99d21e13c',
    messagingSenderId: '467529108341',
    projectId: 'mantan-pos-e731d',
    databaseURL: 'https://mantan-pos-e731d-default-rtdb.firebaseio.com',
    storageBucket: 'mantan-pos-e731d.appspot.com',
    iosClientId: '467529108341-ur73puq2i8lrrhg9mn04edevf2d1umfv.apps.googleusercontent.com',
    iosBundleId: 'com.example.mantanPos.RunnerTests',
  );
}
