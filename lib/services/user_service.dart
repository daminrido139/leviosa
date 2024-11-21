import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leviosa/model/user_model.dart';

class UserService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<UserModel?> getUserData(
    String college,
    String username,
  ) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return null;
    }
    final college = email.split('@')[1].split('.')[0];
    final userData = (await _firestore
            .collection('school')
            .doc(college)
            .collection('users')
            .doc(email)
            .get())
        .data();
    if (userData == null) {
      return null;
    }
    return UserModel.fromJson(userData);
  }
}
