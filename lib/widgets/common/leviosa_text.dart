import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
//import 'package:leviosa/cubit/user_cubit.dart';

class LeviosaText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? softWrap;
  final Language? forceLanguage;
  const LeviosaText(
    this.text, {
    super.key,
    this.style,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 10,
    this.textAlign,
    this.softWrap,
    this.forceLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text, //widget.text,
      style: style,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}
