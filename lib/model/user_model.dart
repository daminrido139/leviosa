import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leviosa/constants.dart';

class UserModel {
  final Timestamp createdAt;
  final String name;
  final String? profilePicture;
  final UserRole role;
  final String? rollno;
  final Language language;
  final String? wardUsername;

  const UserModel(
      {required this.language,
      required this.createdAt,
      required this.name,
      required this.profilePicture,
      required this.role,
      required this.rollno,
      required this.wardUsername});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        createdAt: json["created_at"],
        name: json["name"],
        profilePicture: json["profile_picture"],
        role: UserRole.values
            .firstWhere((s) => s.toString().split('.')[1] == json["role"]),
        rollno: json['rollno'],
        language: json["language"] == null
            ? Language.english
            : Language.values.firstWhere(
                (s) => s.toString() == json["language"],
              ),
        wardUsername: json["ward_username"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "created_at": createdAt,
      "name": name,
      "profile_picture": profilePicture,
      "role": role.toString(),
      "rollno": rollno,
      "language": language.toString(),
      "ward_username": wardUsername
    };
  }
}
