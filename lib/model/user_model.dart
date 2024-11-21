import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leviosa/constants.dart';

class UserModel {
  final Timestamp createdAt;
  final String name;
  final String? profilePicture;
  final UserRole role;

  const UserModel({
    required this.createdAt,
    required this.name,
    required this.profilePicture,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createdAt: json["created_at"],
      name: json["name"],
      profilePicture: json["profile_picture"],
      role: UserRole.values.firstWhere((s) => s.toString() == json["role"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created_at": createdAt,
      "name": name,
      "profile_picture": profilePicture,
      "role": role.toString(),
    };
  }
}
