import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';

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

  static String getUserId() => FirebaseAuth.instance.currentUser!.email!;

  static Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  ///////////// only for debug /////////////////////////
  static Future<void> switchUser(String email, BuildContext context) async {
    await logout();
    await signInWithEmailAndPassword(email, 'Legendary123');
    context.go(RouterConstants.appEntry);
  }
}
