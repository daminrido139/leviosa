import 'package:flutter/material.dart';
import 'package:leviosa/services/calendar_services.dart';
import 'package:leviosa/services/common_services.dart';

class WeekDayBox extends StatelessWidget {
  final int day;
  const WeekDayBox({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: isLightMode(context) ? Colors.white : Colors.black,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: Text(
        CalendarServices.getDayByInd(day),
        style: const TextStyle(
            fontSize: 17, color: Color.fromARGB(255, 134, 134, 143)),
      ),
    );
  }
}
