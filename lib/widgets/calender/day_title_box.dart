import 'package:flutter/material.dart';
import 'package:leviosa/services/calendar_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class DayTitleBox extends StatelessWidget {
  final DateTime dateTime;
  const DayTitleBox({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
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
        '${CalendarServices.getMonthByInd(dateTime.month)} ${dateTime.day}, ${dateTime.year}',
        style: const TextStyle(
          fontSize: 17,
          color: Color.fromARGB(255, 134, 134, 143),
        ),
      ),
    );
  }
}
