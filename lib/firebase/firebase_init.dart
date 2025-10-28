import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseInit {
  static Future<void> initializeFirebase() async {
    if (Firebase.apps.isNotEmpty) return;
    // Prefer passing these via --dart-define to avoid hardcoding in git
    const String apiKey = String.fromEnvironment('FIREBASE_API_KEY', defaultValue: 'AIzaSyBHY8DxT15wjr1acCObJaLnyGcKFHq8V2s');
    const String projectId = String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: 'health-care-rhixz');
    const String appIdAndroid = String.fromEnvironment('FIREBASE_ANDROID_APP_ID', defaultValue: '1:876407532094:android:b13d5c2f2e422b2662bf6f');
    const String appIdWeb = String.fromEnvironment('FIREBASE_WEB_APP_ID', defaultValue: '1:876407532094:web:7a33e755a4d6124a62bf6f');
    const String messagingSenderId = String.fromEnvironment('FIREBASE_SENDER_ID', defaultValue: '876407532094');
    const String storageBucket = String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: 'health-care-rhixz.appspot.com');
    const String authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: 'health-care-rhixz.firebaseapp.com');
    const String databaseURL = String.fromEnvironment('FIREBASE_DATABASE_URL', defaultValue: 'https://health-care-rhixz-default-rtdb.asia-southeast1.firebasedatabase.app');
    const String measurementId = String.fromEnvironment('FIREBASE_MEASUREMENT_ID', defaultValue: 'G-2KN2JSZGBT');

    final FirebaseOptions options = kIsWeb
        ? FirebaseOptions(
            apiKey: apiKey,
            appId: appIdWeb,
            messagingSenderId: messagingSenderId,
            projectId: projectId,
            authDomain: authDomain,
            storageBucket: storageBucket,
            databaseURL: databaseURL,
            measurementId: measurementId,
          )
        : const FirebaseOptions(
            apiKey: apiKey,
            appId: appIdAndroid,
            messagingSenderId: messagingSenderId,
            projectId: projectId,
            storageBucket: storageBucket,
          );

    await Firebase.initializeApp(options: options);
  }
}
