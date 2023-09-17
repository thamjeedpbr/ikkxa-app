// ignore_for_file: lines_longer_than_80_chars
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

    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7kstNKXmc2fq6tJw7jgp-YyYYRvrAwl4',
    appId: '1:888682993452:android:052a8b4ead5b8b22f03e89',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxx',
    projectId: 'ikxxa-saudi',
    databaseURL: 'xxxxxxxxxxxxxxxxxxx',
    storageBucket: 'xxxxxxxxxxxxxxxxxxx',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7kstNKXmc2fq6tJw7jgp-YyYYRvrAwl4',
    appId: '1:888682993452:android:052a8b4ead5b8b22f03e89',
    messagingSenderId: 'xxxxxxxxxxxxxxxxxxx',
    projectId: 'xxxxxxxxxxxxxxxxxxx',
    databaseURL: 'xxxxxxxxxxxxxxxxxxx',
    storageBucket: 'xxxxxxxxxxxxxxxxxxx',
    androidClientId: 'xxxxxxxxxxxxxxxxxxx',
    iosClientId: 'xxxxxxxxxxxxxxxxxxx',
    iosBundleId: 'xxxxxxxxxxxxxxxxxxx',
  );
}