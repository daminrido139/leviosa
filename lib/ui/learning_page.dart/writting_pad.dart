import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class WritingPad extends StatelessWidget {
  final double? height;
  const WritingPad({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    final SignatureController controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.red,
      exportBackgroundColor: Colors.blue,
    );

    final screenHeight = height == null
        ? (MediaQuery.of(context).size.height - 270)
        : height! - 84;
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Signature(
            controller: controller,
            width: MediaQuery.of(context).size.width,
            height: screenHeight,
            backgroundColor: const Color.fromARGB(255, 233, 223, 190),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            controller.clear();
          },
          child: const Text(
            "Clear",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ));
  }
}
