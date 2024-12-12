import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/ai_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/sign_language/t2sign_box.dart';

class MathsAdditionPage extends StatefulWidget {
  const MathsAdditionPage({super.key});

  @override
  State<MathsAdditionPage> createState() => _MathsAdditionPageState();
}

class _MathsAdditionPageState extends State<MathsAdditionPage> {
  int currentPage = 0;
  static const int maxPage = 9;
  double height = 0;
  final List<int> operands = [];
  final random = Random();
  bool isSignMode = true;

  Map<String, String>? modelsInDb;

  Future<void> initialize() async {
    modelsInDb = await AiServices.fetch3DModels();
    setState(() {});
  }

  @override
  void initState() {
    generateOperands();
    initialize();

    super.initState();
  }

  void generateOperands() {
    for (int i = 0; i < maxPage; ++i) {
      operands.add(random.nextInt(5) + 1);
      operands.add(random.nextInt(4) + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    int curLeftOperand = operands[currentPage * 2];
    int curRightOperand = operands[currentPage * 2 + 1];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              isSignMode = !isSignMode;

              setState(() {});
            },
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
              child: Icon(
                isSignMode
                    ? Icons.hexagon_outlined
                    : Icons.emoji_people_outlined,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: isSignMode
          ? T2signBox(
              key: UniqueKey(),
              sentence:
                  '$curLeftOperand plus $curRightOperand is equal to ${curRightOperand + curLeftOperand}',
              width: width * 0.9,
              height: height * 0.8,
              modelsInDb: modelsInDb,
              labelSize: 24,
            )
          : Column(
              children: [
                SizedBox(height: height * 0.05),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children:
                            generateShapes(curLeftOperand, 48, Colors.red),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: generateShapes(
                                curLeftOperand + curRightOperand,
                                48,
                                Colors.blue)
                            .sublist(curLeftOperand),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: leviosaColor, width: 4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: generateShapes(
                      curLeftOperand + curRightOperand,
                      48,
                      Colors.teal,
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
                    const Text(
                      "+",
                      style:
                          TextStyle(fontSize: 72, fontWeight: FontWeight.w900),
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
                      style:
                          TextStyle(fontSize: 72, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      getGujaratiNumber(
                          (curLeftOperand + curRightOperand).toString()),
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w900,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
      bottomNavigationBar: bottomBar(),
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
