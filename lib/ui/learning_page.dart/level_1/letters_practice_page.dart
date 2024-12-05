import 'package:flutter/material.dart';
import 'package:leviosa/ui/canvas/drawing_board.dart';

class LettersPracticePage extends StatelessWidget {
  const LettersPracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Column(
        children: [
          Container(height: height * 0.3, color: Colors.black),
          const Expanded(child: DrawingBoard()),
          Container(height: height * 0.2, color: Colors.green),
        ],
      ),
    );
  }
}
