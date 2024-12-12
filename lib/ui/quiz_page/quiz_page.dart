import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/sign_language/t2sign_box.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String? selectedAns;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leviosaColor,
        title: LeviosaText(
          "ક્વિઝ શરૂ કરો (${index + 1}/${QuizConsts.quiz1.length})",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
              value: index / QuizConsts.quiz1.length,
              color: Colors.green.shade700,
              minHeight: 30),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: LeviosaText(
              "${getGujaratiNumber((index + 1).toString())}) ${QuizConsts.quiz1[index][0]}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          T2signBox(
            sentence: QuizConsts.quiz1[index][4],
            width: 200,
            height: 450,
            showOnlySign: true,
            loop: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              answerContainer(
                getGujaratiNumber(QuizConsts.quiz1[index][1]),
              ),
              answerContainer(
                getGujaratiNumber(QuizConsts.quiz1[index][2]),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              answerContainer(
                getGujaratiNumber(QuizConsts.quiz1[index][3]),
              ),
              answerContainer(
                getGujaratiNumber(QuizConsts.quiz1[index][4]),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          selectedAns == null
              ? const SizedBox.shrink()
              : selectedAns == getGujaratiNumber(QuizConsts.quiz1[index][5])
                  ? const Text(
                      "સાચો જવાબ 🥳",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 32,
                      ),
                    )
                  : const Text("ખોટો જવાબ",
                      style: TextStyle(color: Colors.red, fontSize: 32))
        ],
      ),
    );
  }

  Widget answerContainer(String ans) {
    return InkWell(
      onTap: () async {
        selectedAns = ans;
        setState(() {});
        await Future.delayed(Durations.extralong4);
        if (selectedAns == getGujaratiNumber(QuizConsts.quiz1[index][5])) {
          if (index == QuizConsts.quiz1.length - 1) {
            context.pop();
          } else {
            index += 1;
          }
        }
        selectedAns = null;

        setState(() {});
      },
      child: Container(
        height: 60,
        width: 150,
        decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(2.5, 2.5),
              colors: selectedAns == null
                  ? [Colors.white, const Color.fromRGBO(153, 153, 153, 1)]
                  : ans == getGujaratiNumber(QuizConsts.quiz1[index][5])
                      ? [Colors.green, Colors.green]
                      : [Colors.red, Colors.red],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ]),
        child: Center(
            child: LeviosaText(
          ans,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
