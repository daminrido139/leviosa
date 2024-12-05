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
    "qcdivQfA41Y",
  ];
  static const List level1 = [
    ["assets/img/learnimg3.webp", "NUMBERS", "(0-1000)"],
    ["assets/img/learnimage2.webp", "ALPHABETS", "(A-Z)"],
  ];
  // static const List horizontallst = [
  //   "assets/img/class1.jpeg",
  //   "assets/img/class2.jpeg",
  //   "assets/img/class3.jpeg",
  //   "assets/img/class4.jpeg",
  //   "assets/img/class5.jpeg",
  //   "assets/img/class6.jpeg",
  //   "assets/img/class7.jpeg",
  //   "assets/img/class8.jpeg",
  // ];
}

const Color leviosaColor = Color.fromARGB(255, 243, 227, 173);

////////////////////////////// English to Gujarathi ////////////////////////////

final gujarat = {"Chats": "ચેટ્સ"};



////////////////////////////////////////////////////////////////////////////////