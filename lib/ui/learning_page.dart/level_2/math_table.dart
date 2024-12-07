import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';

class MathTable extends StatelessWidget {
  const MathTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leviosaColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Math Tables",
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 20,
            runSpacing: 25,
            children: List.generate(10, (i) => buildTable(i + 1)),
          ),
        ),
      ),
    );
  }

  Widget buildTable(int n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Table ${getGujaratiNumber(n.toString())}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 7),
        ...List.generate(
            10,
            (i) => Text(
                  "${getGujaratiNumber(n.toString())} x ${getGujaratiNumber((i + 1).toString())} = ${getGujaratiNumber((n * (i + 1)).toString())}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                )),
      ],
    );
  }
}
