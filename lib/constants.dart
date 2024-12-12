import 'package:flutter/material.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/common_services.dart';

//const String leviosaServer = 'https://signify-server.onrender.com';

enum UserRole {
  student,
  teacher,
  parent,
  hr,
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

enum LetterType { number, vowels, consonants, quiz }

class Utility {
  static const List youtubeLevel1 = [
    "vnH2BmcSRMA",
    "ZXB_8AHG0PU",
    "ZXB_8AHG0PU",
  ];
  static const List level1 = [
    [
      "assets/level_1/gujarati_numbers.webp",
      "Numbers",
      "(૦-૯)",
      LetterType.number,
    ],
    [
      "assets/level_1/gujrati_vowels.jpg",
      "Vowels",
      "(અ-ઔ)",
      LetterType.vowels,
    ],
    [
      "assets/level_1/gujarati_consonants.jpg",
      "Consonants",
      "(ક-જ્ઞ)",
      LetterType.consonants,
    ],
  ];
  static const List level2 = [
    [
      "assets/level_2/add.png",
      "Addition",
      "વધુમાં",
      RouterConstants.mathsAdditionPage,
    ],
    [
      "assets/level_2/minus.png",
      "Subtraction",
      "બાદબાકી",
      RouterConstants.mathsSubtractionPage,
    ],
    [
      "assets/level_2/multiply.png",
      "Multiplication",
      "ગુણાકાર",
      RouterConstants.mathsMultiplyPage,
    ],
    [
      "assets/level_2/calculator.png",
      "Math Tables",
      "ગણિત",
      RouterConstants.mathsTablePage,
    ],
    [
      "assets/level_2/divide.png",
      "Division",
      "ડિવિઝન",
      RouterConstants.mathsDivisionPage,
    ],
  ];
  static const List level3 = [
    [
      "assets/level_1/gujarati_consonants.jpg",
      "Basic words",
      "મૂળભૂત શબ્દો",
      RouterConstants.sentence2TextLevelPage,
    ],
  ];
}

const Color leviosaColor = Color.fromRGBO(243, 227, 173, 1);
const Color secondaryColor = Color.fromARGB(255, 12, 28, 82);

///////////////// music links ///////////////////////////
const String kidsBgm = 'music/kids_bgm.mp3';

////////////////////////////// English to Gujarathi ////////////////////////////

final gujarat = {"Chats": "ચેટ્સ"};
final List answer = ["૦", "૧", "૨", "૩"];

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

/////////// prompt /////////////////
const String text2signPrompt = '''
we are translating sentence to Indian sign language. I have animated 3D models for alphabets and some words.
if i give you a sentence, change the format according to the ISL rules and return each word with a single space.

Rules
  the verb should go to the last
  every word should be in simple present tense
  should eliminate all the connecting words such as is, was, have, been, etc..

Example sentence:
input: He is drinking water
output: He water drink

input: 1
output: 1

input: I eat 2 apples
output: I 2 apple eat

input: Good morning!
output: Good morning

Note: the output only contains alphabets, numbers and space, it should not contain any other punctuations or special characters
''';

class QuizConsts {
  static final List<List<String>> quiz1 = [
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "5", "6", "7", "8", "5"],
    ["", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
    ["સાચો જવાબ પસંદ કરો", "0", "1", "2", "3", "2"],
  ];
}

const String translationPrompt = '''
I am developing an app targeting Gujaratians.
You are a translator. If i input a english letter, number, word or sentence, you have to provide an accuurate translation of it in Gujarati

Example:

input: 1
output: ૧

input: morning
output: સવાર

input: good morning
output: સુપ્રભાત

''';

const List<String> alphabets = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
];

const Map<String, String> english2Gujarati = {
  'good': 'સારું',
  'morning': 'સુપ્રભાત',
};

String convertToGujarati(String text) {
  text = text.trim();
  if (int.tryParse(text) != null) {
    return getGujaratiNumber(text);
  }
  if (english2Gujarati[text] != null) {
    return english2Gujarati[text]!;
  }
  return '';
}
