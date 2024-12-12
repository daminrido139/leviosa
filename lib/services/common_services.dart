import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/theme_cubit.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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

String getGujaratiNumber(String n) {
  const List<String> nums = ["૦", "૧", "૨", "૩", "૪", "૫", "૬", "૭", "૮", "૯"];
  return List<String>.generate(
      n.length, (i) => nums[int.parse(n[i])].toString()).join();
}

List<Widget> generateShapes(
  int count,
  double size, [
  Color color = Colors.black,
]) {
  List<Widget> shapes = [
    Container(
      height: size * 1.1,
      width: size * 1.1,
      decoration: ShapeDecoration(
        shape: const StarBorder.polygon(sides: 5),
        color: color,
      ),
    ),
    Container(
      height: size,
      width: size,
      decoration: ShapeDecoration(
        shape: const Border(),
        color: color,
      ),
    ),
    Container(
      height: size * 1.2,
      width: size * 1.2,
      decoration: ShapeDecoration(
        shape: const StarBorder(),
        color: color,
      ),
    ),
    Container(
      height: size * 1.2,
      width: size * 1.2,
      decoration: ShapeDecoration(
        shape: const StarBorder.polygon(sides: 3),
        color: color,
      ),
    ),
    Container(
      height: size * 1.1,
      width: size * 1.1,
      decoration: ShapeDecoration(
        shape: const StarBorder.polygon(sides: 4),
        color: color,
      ),
    ),
    Container(
      height: size,
      width: size,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: color,
      ),
    ),
  ];
  return List<Widget>.generate(
    count,
    (i) => shapes[i % shapes.length],
    growable: false,
  );
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

Future<String> saveUint8ListToFile(Uint8List uint8list, String fileName) async {
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);
  await file.writeAsBytes(uint8list);
  return filePath;
}

Future<String?> mergeVideos(List<Uint8List> videoList) async {
  final tempDir = await getTemporaryDirectory();
  final filePaths = <String>[];
  for (int i = 0; i < videoList.length; i++) {
    final path = await saveUint8ListToFile(videoList[i], 'video_$i.mp4');
    filePaths.add(path);
  }

  final listFilePath = '${tempDir.path}/${generateRandomFilename()}.txt';
  final listFile = File(listFilePath);
  final listContent = filePaths.map((path) => "file '$path'").join('\n');
  await listFile.writeAsString(listContent);

  final outputPath = '${tempDir.path}/${generateRandomFilename()}.mp4';
  final command = '-f concat -safe 0 -i $listFilePath -c copy $outputPath';
  await FFmpegKit.execute(command);

  return outputPath;
}

Future<Uint8List?> downloadFileAsUint8List(String fileUrl) async {
  try {
    final response = await http.get(Uri.parse(fileUrl));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  } catch (e) {
    return null;
  }
  return null;
}

String generateRandomFilename() {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final rnd = Random();
  final randomString = String.fromCharCodes(Iterable.generate(
      10, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  return randomString;
}
