import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leviosa/model/user_model.dart';

class UserService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<UserModel?> getUserData([String? email]) async {
    email = email ?? FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return null;
    }
    final school = email.split('@')[1].split('.')[0];
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
