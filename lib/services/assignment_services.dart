import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leviosa/model/assignment_model.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/services/course_service.dart';

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

  static Future<List<AssignmentModel>> fetchAssignmentStudent() async {
    final courses = await CourseService.fetchMyLearningCourses();
    final email = FirebaseAuth.instance.currentUser!.email!;
    final school = getSchool(email);
    List<AssignmentModel> assignments = [];
    // for (CourseModel course in courses) {
    final snapshot = await _firestore
        .collection('school')
        .doc(school)
        .collection('Assignment')
        .get();
    // .where(
    //   'course_code',
    //   isEqualTo: course.courseCode,
    // )
    // .get(const GetOptions(source: Source.server));

    final data = snapshot.docs
        .map((q) => AssignmentModel.fromJson(
              q.data(),
            ))
        .toList();
    assignments.addAll(data);
    // }
    return assignments;
  }

  static Future<List<AssignmentModel>> fetchAssignmentTeacher() async {
    final courses = await CourseService.fetchMyTeachingCourses();
    final email = FirebaseAuth.instance.currentUser!.email!;
    final school = getSchool(email);
    List<AssignmentModel> assignments = [];
    // for (CourseModel course in courses) {
    final snapshot = await _firestore
        .collection('school')
        .doc(school)
        .collection('Assignment')
        // .where(
        //   'course_code',
        //   isEqualTo: course.courseCode,
        // )
        .get();

    assignments.addAll(snapshot.docs
        .map((q) => AssignmentModel.fromJson(
              q.data(),
            ))
        .toList());
    // }
    return assignments;
  }
}
