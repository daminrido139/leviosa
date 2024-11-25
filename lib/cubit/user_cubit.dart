import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/user_model.dart';

class UserCubit extends Cubit<UserModel> {
  UserCubit()
      : super(
          UserModel(
            createdAt: Timestamp(0, 0),
            name: "",
            profilePicture: null,
            role: UserRole.none,
            rollno: null,
          ),
        );

  void setUser(UserModel userModel) {
    emit(
      UserModel(
        createdAt: userModel.createdAt,
        name: userModel.name,
        profilePicture: userModel.profilePicture,
        role: userModel.role,
        rollno: userModel.rollno,
      ),
    );
  }
}
