import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';

class MathsMultiplyPage extends StatefulWidget {
  const MathsMultiplyPage({super.key});

  @override
  State<MathsMultiplyPage> createState() => _MathsMultiplyPageState();
}

class _MathsMultiplyPageState extends State<MathsMultiplyPage> {
  int currentPage = 0;
  static const int maxPage = 9;
  double height = 0;
  final List<int> operands = [];
  final random = Random();

  @override
  void initState() {
    generateOperands();
    super.initState();
  }

  void generateOperands() {
    for (int i = 0; i < maxPage; ++i) {
      operands.add(random.nextInt(5) + 1);
      operands.add(random.nextInt(5) + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    int curLeftOperand = operands[currentPage * 2];
    int curRightOperand = operands[currentPage * 2 + 1];
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: generateShapes(curLeftOperand, 32, Colors.red),
                ),
              ),
              const Expanded(
                child: Text(
                  "x",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  getGujaratiNumber(
                    curRightOperand.toString(),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 64,
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: leviosaColor, width: 4),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    curRightOperand,
                    (i) => Wrap(
                          direction: Axis.vertical,
                          spacing: 8,
                          children:
                              generateShapes(curLeftOperand, 24, Colors.teal),
                        ))),
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
              const Text(
                "x",
                style: TextStyle(fontSize: 72, fontWeight: FontWeight.w900),
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
                    (curLeftOperand * curRightOperand).toString()),
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

  PreferredSizeWidget? _appBar() => AppBar(
        backgroundColor: leviosaColor,
        scrolledUnderElevation: 0,
        title: const Text('Multiplication'),
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
      );

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
