import 'package:translator/translator.dart';

class LanguageTranslation {
  Future<String> englishToGujarat(String text) async {
    GoogleTranslator translator = GoogleTranslator();
    String gujarati = await translator.translate(text, to: 'gu').then((v) {
      return v.toString();
    });
    return gujarati;
  }
}
