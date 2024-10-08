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
    apiKey: 'AIzaSyAszybV841ueP5mzHlNP6VRVnd8LtLh20k',
    appId: '1:849542900260:web:7ed474eef51d823fca86b1',
    messagingSenderId: '849542900260',
    projectId: 'winpoi',
    authDomain: 'winpoi.firebaseapp.com',
    storageBucket: 'winpoi.appspot.com',
    measurementId: 'G-PE7ZSTW7SK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5AzErmRT84cbW4YziPR3mSDldxdKQBsI',
    appId: '1:849542900260:android:42dd352af06c309bca86b1',
    messagingSenderId: '849542900260',
    projectId: 'winpoi',
    storageBucket: 'winpoi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdsXzqVTAUAuh3RW4NJO3OU7OqwuLF6h0',
    appId: '1:849542900260:ios:328d105f9f4f2626ca86b1',
    messagingSenderId: '849542900260',
    projectId: 'winpoi',
    storageBucket: 'winpoi.appspot.com',
    iosBundleId: 'com.example.findwin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdsXzqVTAUAuh3RW4NJO3OU7OqwuLF6h0',
    appId: '1:849542900260:ios:328d105f9f4f2626ca86b1',
    messagingSenderId: '849542900260',
    projectId: 'winpoi',
    storageBucket: 'winpoi.appspot.com',
    iosBundleId: 'com.example.findwin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAszybV841ueP5mzHlNP6VRVnd8LtLh20k',
    appId: '1:849542900260:web:4cfd18c18bcbc49dca86b1',
    messagingSenderId: '849542900260',
    projectId: 'winpoi',
    authDomain: 'winpoi.firebaseapp.com',
    storageBucket: 'winpoi.appspot.com',
    measurementId: 'G-ZYXJRC331T',
  );
}
