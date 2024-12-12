import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:leviosa/constants.dart';

class AvatarAiServices {
  static final model = GenerativeModel(
    model: 'gemini-1.5-flash-002',
    apiKey: 'AIzaSyAfCKcnsK08BZ_ddwm2KPvuUdvzJ5lqBkA',
  );
  static final chat = model.startChat(history: [Content.text(avatarAiPrompt)]);

  static Future<String> query(String query) async {
    final response = await chat.sendMessage(
      Content.text('query: $query'),
    );
    return response.text ?? '';
  }
}
