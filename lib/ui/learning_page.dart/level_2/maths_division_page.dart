import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';

class MathsDivisionPage extends StatefulWidget {
  const MathsDivisionPage({super.key});

  @override
  State<MathsDivisionPage> createState() => _MathsDivisionPageState();
}

class _MathsDivisionPageState extends State<MathsDivisionPage> {
  int currentPage = 0;
  static const int maxPage = 7;
  double height = 0;
  final List<int> operands = [6, 2, 4, 2, 12, 3, 10, 5, 6, 3, 8, 2, 12, 4];
  final random = Random();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    int curLeftOperand = operands[currentPage * 2];
    int curRightOperand = operands[currentPage * 2 + 1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.1),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: List.generate(
                        curLeftOperand ~/ curRightOperand,
                        (_) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: generateShapes(
                                    curRightOperand, 20, Colors.red),
                              ),
                            )),
                  )),
              Expanded(
                  child: Center(
                child: SizedBox.square(
                  dimension: 48,
                  child: Image.asset("assets/level_2/divide.png"),
                ),
              )),
              Expanded(
                flex: 3,
                child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: generateShapes(curRightOperand, 20, Colors.blue)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: leviosaColor, width: 4),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              getGujaratiNumber((curLeftOperand ~/ curRightOperand).toString()),
              style: const TextStyle(
                fontSize: 164,
                color: Colors.teal,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                getGujaratiNumber(curLeftOperand.toString()),
                style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.red),
              ),
              SizedBox.square(
                dimension: 48,
                child: Image.asset("assets/level_2/divide.png"),
              ),
              Text(
                getGujaratiNumber(curRightOperand.toString()),
                style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              const Text(
                "=",
                style: TextStyle(fontSize: 72, fontWeight: FontWeight.w900),
              ),
              Text(
                getGujaratiNumber(
                    (curLeftOperand ~/ curRightOperand).toString()),
                style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.teal),
              ),
            ],
          ),
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
          '${currentPage + 1}/$maxPage',
          style: const TextStyle(fontSize: 18),
        ),
        GestureDetector(
          onTap: () {
            if (currentPage < maxPage - 1) {
              currentPage += 1;
              setState(() {});
            } else if (currentPage == maxPage - 1) {
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
