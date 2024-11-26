import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leviosa/model/user_model.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/common_services.dart';

class UserService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    final String email = AuthService.getUserId();
    final school = email.split('@')[1].split('.')[0];
    return (await _firestore
        .collection("school")
        .doc(school)
        .collection('users')
        .get());
  }

  static Future<UserModel?> getUserData([String? email]) async {
    email = email ?? FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return null;
    }
    final school = getSchool(email);
    final userData = (await _firestore
            .collection('school')
            .doc(school)
            .collection('users')
            .doc(email)
            .get())
        .data();
    if (userData == null) {
      return null;
    }
    print(userData);
    return UserModel.fromJson(userData);
  }
}
