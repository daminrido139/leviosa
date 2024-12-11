import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';

class AiServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyAfCKcnsK08BZ_ddwm2KPvuUdvzJ5lqBkA',
  );
  static final chat = model.startChat(history: [Content.text(text2signPrompt)]);

  static Future<Map<String, String>> fetch3DModels() async {
    final snap = (await _firestore.collection('avatar').get()).docs;
    Map<String, String> avatars = {};
    for (int i = 0; i < snap.length; i++) {
      final s = snap[i];
      final name = s.id.startsWith('_') ? s.id.substring(1) : s.id;
      avatars[name] = s.data()['url'];
    }
    return avatars;
  }

  static Future<String> formatSentence(String userInput) async {
    final response = await chat.sendMessage(
      Content.text(userInput),
    );
    return response.text ?? '';
  }

  static Future<String?> generateAvatar(
      String sentence, Map<String, String> modelsInDb) async {
    if (sentence.isEmpty) {
      return null;
    }
    final words = sentence.split(' ');
    List<String> formattedWordsUrl = [];
    //////////////////////////////////////////
    for (String w in words) {
      w = w.trim().toLowerCase();

      if (modelsInDb.containsKey(w)) {
        if (modelsInDb[w] != null) {
          formattedWordsUrl.add(modelsInDb[w]!);
        }
      } else {
        for (var char in w.split('')) {
          if (modelsInDb.containsKey(char)) {
            if (modelsInDb[char] != null) {
              formattedWordsUrl.add(modelsInDb[char]!);
            }
          }
        }
      }
    }
    print(formattedWordsUrl);
    //////////////////////////////////////////////
    List<Uint8List> videos = [];
    for (String url in formattedWordsUrl) {
      final video = await downloadFileAsUint8List(url);
      if (video != null) {
        videos.add(video);
      }
    }
    final mergedVideo = await mergeVideos(videos);
    return mergedVideo;
  }
}
