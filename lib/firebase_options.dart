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
    apiKey: 'AIzaSyDFi9oIyLxX0W_pi7pwyuk81cxicoJlY0I',
    appId: '1:18944910770:web:b44cde12328c05b97930ab',
    messagingSenderId: '18944910770',
    projectId: 'dev-chat-9f670',
    authDomain: 'dev-chat-9f670.firebaseapp.com',
    storageBucket: 'dev-chat-9f670.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdRiAmOP_SM9CIvaRdCVKjXu4LPNzYmE8',
    appId: '1:18944910770:android:1d5ffec6494427107930ab',
    messagingSenderId: '18944910770',
    projectId: 'dev-chat-9f670',
    storageBucket: 'dev-chat-9f670.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7laQkhu0SV4joOZeMorQunJ1Qi8LHC84',
    appId: '1:18944910770:ios:2272dd5ad2d3f1347930ab',
    messagingSenderId: '18944910770',
    projectId: 'dev-chat-9f670',
    storageBucket: 'dev-chat-9f670.appspot.com',
    androidClientId: '18944910770-roit8228csfgr3slo8vguhd2vjrop0d9.apps.googleusercontent.com',
    iosClientId: '18944910770-3mtgtdvkfmtckqq8hjtuf3tkbldjkvqq.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );
}