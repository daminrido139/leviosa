import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;
  static bool isLoggedIn() => _firebaseAuth.currentUser != null;

  static Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
