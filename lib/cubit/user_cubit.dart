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
              language: Language.english,
              wardUsername: null),
        );

  void setUser(UserModel userModel) {
    emit(userModel);
  }

  void changeLanguage(Language language) {
    emit(
      UserModel(
          createdAt: state.createdAt,
          name: state.name,
          profilePicture: state.profilePicture,
          role: state.role,
          rollno: state.rollno,
          language: language,
          wardUsername: state.wardUsername),
    );
  }
}
