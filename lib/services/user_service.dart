import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/model/user_model.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/common_services.dart';

class UserService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    final String email = AuthService.getUserId();
    final school = getSchool(email);
    return (await _firestore
        .collection("school")
        .doc(school)
        .collection('users')
        .get());
  }

  static Future<void> setLanguage(Language language) async {
    final String email = AuthService.getUserId();
    final school = getSchool(email);
    await _firestore
        .collection("school")
        .doc(school)
        .collection('users')
        .doc(email)
        .set({'language': language.toString()}, SetOptions(merge: true));
  }

  static String? getWardusername(BuildContext context) {
    return context.read<UserCubit>().state.wardUsername;
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
    return UserModel.fromJson(userData);
  }
}
