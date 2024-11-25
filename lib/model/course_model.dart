import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final Timestamp createdAt;
  final String courseName;
  final String createrId;
  final String courseCode;
  final List<String> participantsId;

  const CourseModel(
      {required this.createdAt,
      required this.courseName,
      required this.courseCode,
      required this.createrId,
      required this.participantsId});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      createdAt: json["created_at"],
      courseName: json["courseName"],
      courseCode: json["courseCode"],
      createrId: json["createrId"],
      participantsId: json["participantsId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created_at": createdAt,
      "course_name": courseName,
      "creater_id": createrId,
      "course_code": courseCode,
      "participants_id": participantsId,
    };
  }
}
