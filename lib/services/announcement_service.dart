import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/user_model.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/services/user_service.dart';

class AnnouncementService {
  static final _firestore = FirebaseFirestore.instance;

  static void sendAnnouncement(
      String courseId, String senderId, String message) {
    final school = getSchool(senderId);
    _firestore
        .collection("school")
        .doc(school)
        .collection("courses")
        .doc(courseId)
        .collection("announcements")
        .add({
      "message": message,
      "sender_id": senderId,
      "created_at": Timestamp.now(),
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> listenAnnouncement(
    String courseId,
  ) {
    final school = getSchool(AuthService.getUserId());
    return _firestore
        .collection("school")
        .doc(school)
        .collection("courses")
        .doc(courseId)
        .collection("announcements")
        .orderBy("created_at")
        .snapshots();
  }

  static Future<Map<String, UserModel?>> getTeachersInfo(
    String courseId,
  ) async {
    final school = getSchool(AuthService.getUserId());
    final Map<String, UserModel?> ret = {};

    final data = (await _firestore
            .collection("school")
            .doc(school)
            .collection("courses")
            .doc(courseId)
            .get())
        .data()!;

    UserModel? userData = (await UserService.getUserData(data["creater_id"]));

    ret[data["creater_id"]] = userData;

    for (String userId in data["participants_id"]) {
      userData = (await UserService.getUserData(userId));
      if (userData?.role == UserRole.teacher) {
        ret[userId] = userData;
      }
    }
    return ret;
  }
}
