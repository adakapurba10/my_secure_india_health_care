import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final UserCredential uc = await _auth.signInAnonymously();
      return uc.user;
    } catch (_) {
      return null;
    }
  }

  Future<bool> canAuthenticateBiometric() async => false;
  Future<bool> authenticateBiometric() async => true;
}
