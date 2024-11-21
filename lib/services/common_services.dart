import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/cubit/theme_cubit.dart';

bool isLightMode(BuildContext context) {
  return context.watch<ThemeCubit>().isLightTheme();
}

String pad0(int t) {
  return t.toString().padLeft(2, '0');
}
