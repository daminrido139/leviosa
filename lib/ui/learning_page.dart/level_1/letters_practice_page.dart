import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/ai_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/services/learning_services.dart';
import 'package:leviosa/ui/canvas/drawing_board.dart';
import 'package:leviosa/widgets/common/adv_network_image.dart';
import 'package:leviosa/widgets/common/loader.dart';
import 'package:leviosa/widgets/sign_language/t2sign_box.dart';

class LettersPracticePage extends StatefulWidget {
  final LetterType type;
  const LettersPracticePage({super.key, required this.type});

  @override
  State<LettersPracticePage> createState() => _LettersPracticePageState();
}

class _LettersPracticePageState extends State<LettersPracticePage> {
  int currentPage = -1;
  List<Map<String, dynamic>> letters = [];
  Map<String, String>? modelsInDb;

  @override
  void initState() {
    super.initState();
    fetchLetters();
    fetchModels();
  }

  Future<void> fetchLetters() async {
    if (widget.type == LetterType.vowels) {
      letters = await LearningServices.fetchLetters();
    } else if (widget.type == LetterType.consonants) {
      letters = await LearningServices.fetchLetters(fetchConsonants: true);
    } else {
      letters = await LearningServices.fetchNumbers();
    }
    currentPage = 0;
    setState(() {});
  }

  Future<void> fetchModels() async {
    modelsInDb = await AiServices.fetch3DModels();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          if (widget.type == LetterType.number)
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: T2signBox(
                          sentence: (currentPage + 1).toString(),
                          modelsInDb: modelsInDb,
                          width: width * 0.9,
                          height: height * 0.9,
                          showClose: true,
                          loop: true,
                          directTranslate: true,
                        ),
                      )),
              child: Container(
                height: 40,
                width: 100,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(2.5, 2.5),
                    colors: [Colors.white, Color.fromRGBO(153, 153, 153, 1)],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.emoji_people_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          const SizedBox(width: 20),
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
                    if (widget.type == LetterType.number)
                      SizedBox(
                        height: height * 0.1,
                        child: Wrap(
                          spacing: 6,
                          runAlignment: WrapAlignment.center,
                          children: generateShapes(
                            currentPage + 1,
                            30,
                            Colors.red,
                          ),
                        ),
                      ),
                    Expanded(
                        child: Stack(
                      children: [
                        DrawingBoard(
                          child: AdvancedNetworkImage(
                            imgUrl: letters[currentPage]['img'],
                          ),
                        ),
                        if (letters[currentPage]["objImg"] != null)
                          Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                child: SizedBox.square(
                                    dimension: 64,
                                    child:
                                        Image.asset("assets/img/teacher.png")),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    letters[currentPage]
                                                        ["objImg"],
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 5,
                                                    child: Text(
                                                      letters[currentPage]
                                                              ["word"] ??
                                                          "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 48,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        backgroundColor:
                                                            Colors.white70,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                              )),
                      ],
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
                                  } else if (currentPage ==
                                      letters.length - 1) {
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
