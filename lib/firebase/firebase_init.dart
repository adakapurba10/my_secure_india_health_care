import 'package:flutter/foundation.dart';

class FirebaseInit {
  static Future<void> initializeFirebase() async {
    // No-op stub for builds where Firebase isn't configured.
    if (kDebugMode) {
      // ignore: avoid_print
      print('FirebaseInit.initializeFirebase(): stubbed for this build.');
    }
  }
}
