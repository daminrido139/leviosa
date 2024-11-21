import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);
  bool isLightTheme() => state == ThemeMode.light;
  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }
}

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromRGBO(243, 242, 248, 1),
    fontFamilyFallback: const ['Apple Color Emoji'],
    // textTheme: TextTheme(
    //   headlineLarge: GoogleFonts.inter(
    //     fontSize: 34,
    //     fontWeight: FontWeight.bold,
    //     color: const Color(0xFF535353),
    //   ),
    //   headlineSmall: GoogleFonts.inter(
    //     color: const Color(0xFF73706B),
    //     fontSize: 24,
    //     fontWeight: FontWeight.w700,
    //   ),
    //   titleMedium: GoogleFonts.inter(
    //     color: const Color(0xFF4E4941),
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //   ),
    //   titleLarge: GoogleFonts.inter(
    //     color: const Color(0xFF5F5F5F),
    //     fontSize: 25,
    //     fontWeight: FontWeight.w700,
    //   ),
    //   bodyMedium: GoogleFonts.inter(
    //     color: const Color(0xFF4D4D4D),
    //     fontSize: 20,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   bodySmall: GoogleFonts.inter(
    //     color: const Color(0xFF3B3B3B),
    //     fontSize: 16,
    //     fontWeight: FontWeight.w400,
    //   ),
    //   labelLarge: GoogleFonts.inter(
    //     color: const Color(0xFF323232),
    //     fontWeight: FontWeight.w600,
    //     fontSize: 14,
    //   ),
    //   labelMedium: GoogleFonts.inter(
    //     color: const Color(0xE02A2A2A),
    //     fontSize: 12,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   labelSmall: GoogleFonts.inter(
    //     color: const Color(0xE02A2A2A),
    //     fontSize: 8.5,
    //     fontWeight: FontWeight.w500,
    //   ),
    // ),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: const WidgetStatePropertyAll(
          Color.fromRGBO(194, 194, 194, 0.7),
        ),
        thickness: const WidgetStatePropertyAll(5)));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF171717),
    fontFamilyFallback: const ['Apple Color Emoji'],
    // textTheme: TextTheme(
    //   headlineLarge: GoogleFonts.inter(
    //     fontSize: 34,
    //     fontWeight: FontWeight.bold,
    //     color: const Color(0xFFDCDCDC),
    //   ),
    //   headlineSmall: GoogleFonts.inter(
    //     color: const Color(0xFFE7E7E7),
    //     fontSize: 24,
    //     fontWeight: FontWeight.w700,
    //   ),
    //   titleLarge: GoogleFonts.inter(
    //     color: const Color(0xFFF2F2F2),
    //     fontSize: 25,
    //     fontWeight: FontWeight.w700,
    //   ),
    //   titleMedium: GoogleFonts.inter(
    //     color: const Color(0xFFC6C6C6),
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //   ),
    //   bodyMedium: GoogleFonts.inter(
    //     color: const Color(0xFFD1D1D1),
    //     fontSize: 20,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   bodySmall: GoogleFonts.inter(
    //     color: const Color(0xFFB6B6B6),
    //     fontSize: 16,
    //     fontWeight: FontWeight.w400,
    //   ),
    //   labelLarge: GoogleFonts.inter(
    //     color: const Color(0xFFD1D1D1),
    //     fontWeight: FontWeight.w600,
    //     fontSize: 13.5,
    //   ),
    //   labelMedium: GoogleFonts.inter(
    //     color: const Color(0xFFB4B4B4),
    //     fontSize: 12,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   labelSmall: GoogleFonts.inter(
    //     color: const Color(0xFFB4B4B4),
    //     fontSize: 8.5,
    //     fontWeight: FontWeight.w500,
    //   ),
    // ),
    scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: const WidgetStatePropertyAll(
          Color.fromRGBO(194, 194, 194, 0.7),
        ),
        thickness: const WidgetStatePropertyAll(5)));
