import 'package:flutter/material.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class WeekNumberBox extends StatelessWidget {
  final DateTime date;
  const WeekNumberBox({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String getWeekNum() {
      final daysToAdd = DateTime.thursday - date.weekday;
      final thursday = daysToAdd > 0
          ? date.add(Duration(days: daysToAdd))
          : date.subtract(Duration(days: daysToAdd.abs()));
      final weekNumber =
          (date.difference(DateTime(thursday.year)).inDays / 7).floor() + 1;
      return weekNumber.toString();
    }

    String getWeek() {
      final week = getWeekNum();
      final lastChar = week.substring(week.length - 1);
      if (lastChar == '1') {
        return '$weekˢᵗ';
      }
      if (lastChar == '2') {
        return '$weekⁿᵈ';
      }
      if (lastChar == '3') {
        return '$weekʳᵈ';
      }
      return '$weekᵗʰ';
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: isLightMode(context) ? Colors.white : Colors.black,
        border: Border.all(
          color: const Color(0xffdddddd),
          width: 0.5,
        ),
      ),
      child: LeviosaText(
        '${getWeek()} week',
        style: const TextStyle(
            fontSize: 17, color: Color.fromARGB(255, 134, 134, 143)),
      ),
    );
  }
}
