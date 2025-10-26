import 'package:firebase_core/firebase_core.dart';

class FirebaseInit {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
}
