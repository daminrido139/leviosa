import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/services/language_translation.dart';

class LeviosaText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? softWrap;
  const LeviosaText(
    this.text, {
    super.key,
    this.style,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 10,
    this.textAlign,
    this.softWrap,
  });

  @override
  State<LeviosaText> createState() => _LeviosaTextState();
}

class _LeviosaTextState extends State<LeviosaText> {
  String? translatedText;
  Language usedLanguage = Language.english;

  Future<void> setLanguage(Language language) async {
    if (usedLanguage == language) {
      return;
    }
    usedLanguage = language;
    if (language == Language.english) {
      translatedText = null;
      return;
    }
    translatedText = await LanguageTranslation.translate(
      widget.text,
      language,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userLanguage = context.watch<UserCubit>().state.language;
    setLanguage(userLanguage);
    return Text(
      translatedText ?? widget.text,
      style: widget.style,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      softWrap: widget.softWrap,
    );
  }
}
