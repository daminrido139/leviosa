import 'package:flutter/material.dart';

class CourseBox extends StatelessWidget {
  const CourseBox({super.key});
  static final List<Color> colors = [
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.yellow.shade200,
    Colors.purple.shade200,
    Colors.blue.shade200,
    Colors.deepOrange.shade200
  ];

  static Color genColor(String char) {
    int index = 0;
    if (char.isEmpty) {
      final int randInt = (DateTime.now().millisecond) % colors.length;
      return colors[randInt];
    }
    for (var i in char.codeUnits) {
      index += i;
    }
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: ListTile(
            leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: genColor("achita"),
                    borderRadius: BorderRadius.circular(8))),
            title: const Text(
              "Auto Mobile Enginerring",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text("U18AU7996"),
          ),
        ));
  }
}
