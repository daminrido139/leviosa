import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leviosa/model/game_model.dart';
import 'package:leviosa/services/auth_service.dart';

class GamingServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // [level, lesson, coins]
  static Future<GameModel> getCurrentGameStatus() async {
    final String email = AuthService.getUserId();
    final snap = await _firestore.collection("status").doc(email).get();
    final data = snap.data();
    if (data == null) {
      return GameModel(
          lastActive: Timestamp.now(),
          lesson: 1,
          level: 1,
          coins: 0,
          streak: 1);
    }
    return GameModel.fromJson(data);
  }

  static Future<int> fetchTotalLessons(int level) async {
    final snap = await _firestore.collection("game").doc('level_$level').get();
    final data = snap.data();
    if (data == null) {
      return 1;
    }
    return data['lessons'] ?? 1;
  }

  static Future<void> updateGameStatus(
      int currentLevel, int completedLesson, int coins) async {
    final totalLesson = await fetchTotalLessons(currentLevel);
    final nextLevel =
        totalLesson == completedLesson ? currentLevel + 1 : currentLevel;
    final nextLesson = totalLesson == completedLesson ? 1 : completedLesson + 1;
    final String email = AuthService.getUserId();
    await _firestore.collection("status").doc(email).set({
      'level': nextLevel,
      'lesson': nextLesson,
      'coins': coins,
    }, SetOptions(merge: true));
  }

  static Future<void> updateStreak(
      Timestamp lastActive, int currentStreak) async {
    final String email = AuthService.getUserId();
    final daysGap =
        Timestamp.now().toDate().difference(lastActive.toDate()).inDays;
    if (daysGap == 1) {
      currentStreak += 1;
    } else if (daysGap > 1) {
      currentStreak = 0;
    }
    await _firestore.collection("status").doc(email).set({
      'streak': currentStreak,
      'last_active': Timestamp.now(),
    }, SetOptions(merge: true));
  }
}
