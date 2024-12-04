import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/leviosa_button.dart';
import 'package:signature/signature.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final SignatureController controller = SignatureController(
    penStrokeWidth: 25,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
          height: 230,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/img/word.gif",
            fit: BoxFit.fill,
          )),
      const SizedBox(
        height: 50,
      ),
      Stack(
        children: [
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 200,
                child: Image.asset(
                  "assets/img/one.png",
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Signature(
                controller: controller,
                width: MediaQuery.of(context).size.width,
                height: 250,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 20,
          ),
          LeviosaButton(
              onTap: () {
                controller.clear();
              },
              child: const Text("Clear")),
          Spacer(),
          LeviosaButton(onTap: () {}, child: const Text("Next")),
          SizedBox(
            width: 20,
          ),
        ],
      )
    ]));
  }
}
