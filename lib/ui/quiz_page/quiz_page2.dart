import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/sign_language/t2sign_box.dart';

class QuizPage2 extends StatefulWidget {
  const QuizPage2({super.key});

  @override
  State<QuizPage2> createState() => _QuizPage2State();
}

class _QuizPage2State extends State<QuizPage2> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leviosaColor,
        title: LeviosaText(
          "ક્વિઝ શરૂ કરો (${index + 1}/${QuizConsts.quiz2.length})",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
              value: index / QuizConsts.quiz2.length,
              color: Colors.green.shade700,
              minHeight: 30),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: LeviosaText(
              "${getGujaratiNumber((index + 1).toString())}) સાચી સંકેત ભાષા પસંદ કરો",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            "૨",
            style: TextStyle(fontSize: 95),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                height: 180,
                width: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const T2signBox(
                    sentence: "2",
                    width: 40,
                    height: 40,
                    showOnlySign: true,
                    loop: true,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                height: 180,
                width: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const T2signBox(
                    sentence: "2",
                    width: 40,
                    height: 40,
                    showOnlySign: true,
                    loop: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                height: 180,
                width: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const T2signBox(
                    sentence: "2",
                    width: 40,
                    height: 40,
                    showOnlySign: true,
                    loop: true,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                height: 180,
                width: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const T2signBox(
                    sentence: "2",
                    width: 40,
                    height: 40,
                    showOnlySign: true,
                    loop: true,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
