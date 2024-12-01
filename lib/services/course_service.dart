import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/services/common_services.dart';

class CourseService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> createCourse(
      List<String> participants, String courseName, String courseCode) async {
    final email = FirebaseAuth.instance.currentUser!.email!;
    final school = getSchool(email);
    await _firestore.collection('school').doc(school).collection('courses').add(
          CourseModel(
            createdAt: Timestamp.now(),
            courseName: courseName,
            courseCode: courseCode,
            createrId: email,
            participantsId: participants,
          ).toJson(),
        );
  }

  static Future<List<CourseModel>> fetchMyTeachingCourses() async {
    final email = FirebaseAuth.instance.currentUser!.email!;
    final school = getSchool(email);
    final snapshot = await _firestore
        .collection('school')
        .doc(school)
        .collection('courses')
        .where(Filter.or(
          Filter('creater_id', isEqualTo: email),
          Filter('participants_id', arrayContains: email),
        ))
        .get();
    return snapshot.docs
        .map((q) => CourseModel.fromJson(q.data(), q.id))
        .toList();
  }

  static Future<List<CourseModel>> fetchMyLearningCourses(
      {String? email}) async {
    email = email ?? FirebaseAuth.instance.currentUser!.email!;
    final school = getSchool(email);
    final snapshot = await _firestore
        .collection('school')
        .doc(school)
        .collection('courses')
        .where('participants_id', arrayContains: email)
        .get();
    return snapshot.docs
        .map((q) => CourseModel.fromJson(q.data(), q.id))
        .toList();
  }
}
