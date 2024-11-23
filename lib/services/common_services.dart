import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/cubit/theme_cubit.dart';

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
