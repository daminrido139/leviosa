import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/theme_cubit.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

bool isLightMode(BuildContext context) {
  return context.watch<ThemeCubit>().isLightTheme();
}

String pad0(int t) {
  return t.toString().padLeft(2, '0');
}

bool isSameDay(DateTime d1, DateTime d2) {
  return (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year);
}

String timestampTohhmmm(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour < 12 ? 'am' : 'pm';

  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }
  String hourStr = pad0(hour);
  String minuteStr = pad0(minute);
  return '$hourStr:$minuteStr $period';
}

String getSchool(String email) {
  return email.split('@')[1].split('.')[0];
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: leviosaColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.info_outline, size: 20),
          const SizedBox(width: 5),
          Expanded(
            child: LeviosaText(
              content,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
