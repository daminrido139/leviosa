import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final Timestamp lastActive;
  final int level;
  final int lesson;
  final int coins;
  final int streak;

  const GameModel({
    required this.lastActive,
    required this.lesson,
    required this.level,
    required this.coins,
    required this.streak,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      lastActive: json["last_active"],
      level: json["level"],
      lesson: json["lesson"],
      coins: json["coins"],
      streak: json["streak"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "last_active": lastActive,
      "level": level,
      "lesson": lesson,
      "coins": coins,
      "streak": streak,
    };
  }
}
