import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/learning_services.dart';
import 'package:leviosa/ui/canvas/drawing_board.dart';
import 'package:leviosa/widgets/common/adv_network_image.dart';
import 'package:leviosa/widgets/common/loader.dart';

class LettersPracticePage extends StatefulWidget {
  const LettersPracticePage({super.key});

  @override
  State<LettersPracticePage> createState() => _LettersPracticePageState();
}

class _LettersPracticePageState extends State<LettersPracticePage> {
  int currentPage = -1;
  List<Map<String, dynamic>> letters = [];

  @override
  void initState() {
    super.initState();
    fetchLetters();
  }

  Future<void> fetchLetters() async {
    letters = await LearningServices.fetchLetters();
    currentPage = 0;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      body: currentPage == -1
          ? const Loader()
          : letters.isEmpty
              ? const Center(
                  child: Text('No letters'),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: height * 0.3,
                      child: AdvancedNetworkImage(
                        imgUrl: letters[currentPage]['gif'],
                        showLoading: true,
                      ),
                    ),
                    Expanded(
                        child: DrawingBoard(
                      child: AdvancedNetworkImage(
                        imgUrl: letters[currentPage]['img'],
                      ),
                    )),
                    SizedBox(
                        height: height * 0.16,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (currentPage > 0) {
                                    currentPage -= 1;
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: 130,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade300,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
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
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              //////////////////////////////////////////
                              Text(
                                '${currentPage + 1}/${letters.length}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (currentPage < letters.length - 1) {
                                    currentPage += 1;
                                    setState(() {});
                                  }
                                  if (currentPage == letters.length - 1) {
                                    context.pop();
                                  }
                                },
                                child: Container(
                                  width: 130,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 66, 224, 45),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
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
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        size: 40,
                                      )
                                    ],
                                  )),
                                ),
                              )
                            ])),
                  ],
                ),
    );
  }
}
