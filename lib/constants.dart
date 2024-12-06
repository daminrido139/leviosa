import 'package:flutter/material.dart';

enum UserRole {
  student,
  teacher,
  parent,
  none,
}

enum Language {
  english,
  gujarati,
  tamil,
  hindi,
}

enum FileType {
  youtube,
  image,
  video,
  pdf,
}

class Utility {
  static const List youtubeLevel1 = [
    "vnH2BmcSRMA",
    "ZXB_8AHG0PU",
    "ZXB_8AHG0PU",
  ];
  static const List level1 = [
    ["assets/level_1/gujarati_numbers.webp", "Numbers", "(૦-૯)"],
    ["assets/level_1/gujrati_vowels.jpg", "Vowels", "(અ-ઔ)"],
    ["assets/level_1/gujarati_consonants.jpg", "Consonants", "(ક-જ્ઞ)"],
  ];
}

const Color leviosaColor = Color.fromARGB(255, 243, 227, 173);

///////////////// music links ///////////////////////////
const String kidsBgm = 'music/kids_bgm.mp3';

////////////////////////////// English to Gujarathi ////////////////////////////

final gujarat = {"Chats": "ચેટ્સ"};

////////////////////////////////////////////////////////////////////////////////// No modifications can be made without a selected code snippet.
// However, some improvements can be suggested for the entire code file.

// Consider using a more descriptive name for the Utility class.
// It's also a good practice to use a private constructor to prevent instantiation of the class.
class Utilities {
  Utilities._();

  // Use a more descriptive name for the youtubeurl list.
  static const List<String> youtubeVideoIds = [
    "vnH2BmcSRMA",
    "qcdivQfA41Y",
    "VtbYvVDItvg",
    "qtrBGmioR2Q",
    "drs0_jcKr5w",
    "XPRtZQSKL-4",
    "x58C6-ZtW_8",
  ];

  // Use a more descriptive name for the verticallst list.
  // Consider using a data class to represent the items in the list.
  static const List<VerticalItem> verticalItems = [
    VerticalItem("assets/img/learnimg3.webp", "NUMBERS", "(0-1000)"),
    VerticalItem("assets/img/learnimage2.webp", "ALPHABETS", "(A-Z)"),
    VerticalItem("assets/img/learnimag1.webp", "WORDS", "(eg.Tiger)"),
    VerticalItem("assets/img/color.jpeg", "Colors", "(eg.blue)"),
    VerticalItem("assets/img/relation.jpeg", "Relations", "(eg.Father)"),
    VerticalItem("assets/img/weaks.jpeg", "Days of the Weak", "(eg.friday)"),
    VerticalItem("assets/img/month.jpeg", "Months", "(eg.Jan)"),
  ];

  // Use a more descriptive name for the horizontallst list.
  static const List<String> horizontalItems = [
    "assets/img/class1.jpeg",
    "assets/img/class2.jpeg",
    "assets/img/class3.jpeg",
    "assets/img/class4.jpeg",
    "assets/img/class5.jpeg",
    "assets/img/class6.jpeg",
    "assets/img/class7.jpeg",
    "assets/img/class8.jpeg",
  ];
}

class VerticalItem {
  final String imagePath;
  final String title;
  final String subtitle;

  const VerticalItem(this.imagePath, this.title, this.subtitle);
}
