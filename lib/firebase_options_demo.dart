// Demo Firebase configuration for NutriQuest
// This file provides safe demo values that won't crash the app
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'demo-api-key',
    appId: '1:demo:web:demo',
    messagingSenderId: 'demo',
    projectId: 'nutriquest-demo',
    authDomain: 'nutriquest-demo.firebaseapp.com',
    storageBucket: 'nutriquest-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:demo:android:demo',
    messagingSenderId: 'demo',
    projectId: 'nutriquest-demo',
    storageBucket: 'nutriquest-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:demo:ios:demo',
    messagingSenderId: 'demo',
    projectId: 'nutriquest-demo',
    storageBucket: 'nutriquest-demo.appspot.com',
    iosBundleId: 'com.nutriquest.demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:demo:ios:demo',
    messagingSenderId: 'demo',
    projectId: 'nutriquest-demo',
    storageBucket: 'nutriquest-demo.appspot.com',
    iosBundleId: 'com.nutriquest.demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:demo:web:demo',
    messagingSenderId: 'demo',
    projectId: 'nutriquest-demo',
    authDomain: 'nutriquest-demo.firebaseapp.com',
    storageBucket: 'nutriquest-demo.appspot.com',
  );
}
