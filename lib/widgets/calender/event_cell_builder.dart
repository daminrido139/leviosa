import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:leviosa/widgets/calender/leviosa_event_tile.dart';

class EventCellBuilder extends StatelessWidget {
  final DateTime date;
  final List<CalendarEventData> events;
  final Rect boundary;
  final DateTime startDuration;
  final DateTime endDuration;
  const EventCellBuilder({
    super.key,
    required this.date,
    required this.events,
    required this.boundary,
    required this.startDuration,
    required this.endDuration,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isNotEmpty) {
      final event = events[0];
      return InkWell(
        onTap: () {},
        child: LeviosaEventTile(
          borderRadius: BorderRadius.circular(10.0),
          title: event.title,
          totalEvents: events.length - 1,
          description: event.description,
          padding: const EdgeInsets.all(10.0),
          backgroundColor: event.color,
          margin: const EdgeInsets.all(2.0),
          titleStyle: event.titleStyle,
          descriptionStyle: event.descriptionStyle,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
