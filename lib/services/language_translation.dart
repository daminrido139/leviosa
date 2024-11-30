import 'package:leviosa/constants.dart';
import 'package:translator/translator.dart';

class LanguageTranslation {
  static final GoogleTranslator translator = GoogleTranslator();

  static Future<String> translate(String text, Language language) async {
    return (await translator.translate(text, to: languageToCode(language)))
        .text;
  }

  static String languageToCode(Language language) {
    switch (language) {
      case Language.english:
        return 'en';
      case Language.gujarati:
        return 'gu';
      case Language.tamil:
        return 'ta';
      case Language.hindi:
        return 'hi';
      default:
        return 'en';
    }
  }
}
