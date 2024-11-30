import 'package:flutter/material.dart';
import 'package:leviosa/services/calendar_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class DayDateBox extends StatelessWidget {
  final DateTime dateTime;
  const DayDateBox({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final cdt = DateTime.now();
    bool isCurrentDate = ((cdt.day == dateTime.day &&
            cdt.month == dateTime.month &&
            cdt.year == dateTime.year)
        ? true
        : false);
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
      child: Column(
        children: [
          LeviosaText(
            CalendarServices.getDayByInd(dateTime.weekday - 1),
            style: const TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 134, 134, 143)),
          ),
          const SizedBox(height: 3),
          CircleAvatar(
            radius: 12,
            backgroundColor: isCurrentDate ? Colors.blue : Colors.transparent,
            child: LeviosaText(
              dateTime.day.toString(),
              style: TextStyle(
                  fontSize: 17,
                  color: isCurrentDate
                      ? Colors.white
                      : const Color.fromARGB(255, 134, 134, 143)),
            ),
          ),
        ],
      ),
    );
  }
}
