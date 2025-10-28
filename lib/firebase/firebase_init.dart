import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseInit {
  static Future<void> initialize() async {
    if (kIsWeb) {
      // Web config
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAS24p4fllvSWSLeHtUJOlqUTtkeXEOQbQ",
          appId: "1:876407532094:web:7a33e755a4d6124a62bf6f",
          messagingSenderId: "876407532094",
          projectId: "health-care-rhixz",
          storageBucket: "health-care-rhixz.appspot.com",
          authDomain: "health-care-rhixz.firebaseapp.com",
          measurementId: "G-2KN2JSZGBT",
          databaseURL: "https://health-care-rhixz-default-rtdb.asia-southeast1.firebasedatabase.app",
        ),
      );
      return;
    }

    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAS24p4fllvSWSLeHtUJOlqUTtkeXEOQbQ",
          appId: "1:876407532094:android:b13d5c2f2e422b2662bf6f",
          messagingSenderId: "876407532094",
          projectId: "health-care-rhixz",
          storageBucket: "health-care-rhixz.appspot.com",
        ),
      );
      return;
    }

    // For iOS/macOS, prefer using GoogleService-Info.plist via default init
    await Firebase.initializeApp();
  }
}
