import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:leviosa/constants.dart';

class LanguageTranslation {
  static final model = GenerativeModel(
    model: 'gemini-1.5-flash-002',
    apiKey: 'AIzaSyAfCKcnsK08BZ_ddwm2KPvuUdvzJ5lqBkA',
  );

  static final chat = model.startChat(history: [Content.text(text2signPrompt)]);

  static Future<String> translate(String text) async {
    try {
      final response = await chat.sendMessage(
        Content.text(text),
      );
      return response.text ?? '';
    } catch (e) {
      return '';
    }
  }

  // static String languageToCode(Language language) {
  //   switch (language) {
  //     case Language.english:
  //       return 'en';
  //     case Language.gujarati:
  //       return 'gu';
  //     case Language.tamil:
  //       return 'ta';
  //     case Language.hindi:
  //       return 'hi';
  //     default:
  //       return 'en';
  //   }
  // }
}
