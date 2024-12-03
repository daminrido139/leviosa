import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {
  final Timestamp createdAt;
  final String courseName;
  final String createrId;
  final String courseCode;
  final String heading;
  final String desc;
  final String dueDate;
  final List<String> attachments;

  const AssignmentModel(
      {required this.createdAt,
      required this.courseName,
      required this.courseCode,
      required this.createrId,
      required this.heading,
      required this.desc,
      required this.dueDate,
      required this.attachments});

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      createdAt: json["created_at"],
      courseName: json["course_name"],
      courseCode: json["course_code"],
      createrId: json["creater_id"],
      heading: json["heading"],
      desc: json["desc"],
      dueDate: json["due_date"],
      attachments: (json["attachments"] as List<String>)
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created_at": createdAt,
      "course_name": courseName,
      "creater_id": createrId,
      "course_code": courseCode,
      "heading": heading,
      "desc": desc,
      "due_date": dueDate,
      "attachments": attachments,
    };
  }
}
