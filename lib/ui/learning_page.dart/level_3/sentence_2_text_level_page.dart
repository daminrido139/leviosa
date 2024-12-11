import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/services/ai_services.dart';

import 'package:leviosa/widgets/sign_language/t2sign_box.dart';

class Sentence2TextLevelPage extends StatefulWidget {
  const Sentence2TextLevelPage({super.key});

  @override
  State<Sentence2TextLevelPage> createState() => _Sentence2TextLevelPageState();
}

class _Sentence2TextLevelPageState extends State<Sentence2TextLevelPage> {
  int currentPage = 0;
  static const List<String> words = [
    'hello',
    'how_are_you',
    'i',
    'i_am_fine',
    'morning',
    'thank_you',
    'welcome',
    'you',
  ];
  double height = 0;
  Map<String, String>? modelsInDb;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    modelsInDb = await AiServices.fetch3DModels();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          T2signBox(
            sentence: words[currentPage],
            width: double.infinity,
            height: height * 0.7,
            modelsInDb: modelsInDb,
            showLocalLanguage: true,
            key: UniqueKey(),
            directTranslate: true,
            loop: true,
          ),
          const Spacer(),
          bottomBar(),
        ],
      ),
    );
  }

  Widget bottomBar() => SizedBox(
      height: height * 0.16,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            )),
          ),
        ),
        //////////////////////////////////////////
        Text(
          '${currentPage + 1}/${words.length}',
          style: const TextStyle(fontSize: 18),
        ),
        GestureDetector(
          onTap: () {
            if (currentPage < (words.length - 1)) {
              currentPage += 1;
              setState(() {});
            } else if (currentPage == words.length - 1) {
              context.pop();
            }
          },
          child: Container(
            width: 130,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 66, 224, 45),
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 40,
                )
              ],
            )),
          ),
        )
      ]));
}
