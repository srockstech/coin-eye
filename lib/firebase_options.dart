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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBk8whiNrvbKuZTx8oa94IHHQelmRMak_M',
    appId: '1:655542102686:android:8eb074082d3bbe5548698f',
    messagingSenderId: '655542102686',
    projectId: 'coineye-8f825',
    storageBucket: 'coineye-8f825.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCiuovuQbQ6huvtZpB3RWKyLqx5yaHaxzQ',
    appId: '1:655542102686:ios:39198eeb07237a7848698f',
    messagingSenderId: '655542102686',
    projectId: 'coineye-8f825',
    storageBucket: 'coineye-8f825.appspot.com',
    androidClientId: '655542102686-d8h6u9m4mtmi06b3sp3beh4u7sv4b8uc.apps.googleusercontent.com',
    iosClientId: '655542102686-d7703mjmn6r8cp0rc4pg939snt7lam1r.apps.googleusercontent.com',
    iosBundleId: 'tech.srocks.coineye',
  );
}
