import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/ui/canvas/drawing_board.dart';

class LettersPracticePage extends StatelessWidget {
  const LettersPracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leviosaColor,
        title: const Text('Letters Practice'),
        actions: const [
          Text(
            "0  🪙",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "0  🔥",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(height: height * 0.3, color: Colors.black),
          const Expanded(child: DrawingBoard()),
          SizedBox(
              height: height * 0.2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 135,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: const Center(
                          child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_left,
                            size: 40,
                          ),
                          Text(
                            "Previous",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      width: 135,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: leviosaColor,
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: const Center(
                          child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 40,
                          )
                        ],
                      )),
                    )
                  ])),
        ],
      ),
    );
  }
}
