
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leviosa/model/assignment_model.dart';
import 'package:leviosa/services/common_services.dart';

class AssignmentServices {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> createAssignment(
      String courseName,
      String courseCode,
      String heading,
      String desc,
      String dueDate,
      List<String> attachments) async {
    final email = FirebaseAuth.instance.currentUser!.email!;
    final school = getSchool(email);
    await _firestore
        .collection('school')
        .doc(school)
        .collection('Assignment')
        .add(AssignmentModel(
                createdAt: Timestamp.now(),
                courseName: courseName,
                courseCode: courseCode,
                createrId: email,
                heading: heading,
                desc: desc,
                dueDate: dueDate,
                attachments: attachments)
            .toJson());
  }
}
