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
    apiKey: 'AIzaSyD4p_uZWtcEnCPeOL724iiNWKJyogVgxwc',
    appId: '1:1069272718398:web:0e7fb9bf2a50ddc8d9056f',
    messagingSenderId: '1069272718398',
    projectId: 'tradmedapp',
    authDomain: 'tradmedapp.firebaseapp.com',
    storageBucket: 'tradmedapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCT8edyLB-DFIHQ55hmI9FUkHgRbjy--Y8',
    appId: '1:1069272718398:android:2d739f084180b555d9056f',
    messagingSenderId: '1069272718398',
    projectId: 'tradmedapp',
    storageBucket: 'tradmedapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkBs5lhHoHwGlu0m08ij2c5XCahNi3viQ',
    appId: '1:1069272718398:ios:91fb6bd6c8fcd9cdd9056f',
    messagingSenderId: '1069272718398',
    projectId: 'tradmedapp',
    storageBucket: 'tradmedapp.appspot.com',
    iosClientId: '1069272718398-b2al134da7u3p4quu7ac2fv7sv3atpdm.apps.googleusercontent.com',
    iosBundleId: 'com.example.tradmed',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkBs5lhHoHwGlu0m08ij2c5XCahNi3viQ',
    appId: '1:1069272718398:ios:91fb6bd6c8fcd9cdd9056f',
    messagingSenderId: '1069272718398',
    projectId: 'tradmedapp',
    storageBucket: 'tradmedapp.appspot.com',
    iosClientId: '1069272718398-b2al134da7u3p4quu7ac2fv7sv3atpdm.apps.googleusercontent.com',
    iosBundleId: 'com.example.tradmed',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4p_uZWtcEnCPeOL724iiNWKJyogVgxwc',
    appId: '1:1069272718398:web:3b08af17ce8fe933d9056f',
    messagingSenderId: '1069272718398',
    projectId: 'tradmedapp',
    authDomain: 'tradmedapp.firebaseapp.com',
    storageBucket: 'tradmedapp.appspot.com',
  );
}
