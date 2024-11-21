import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class MonthCellBuilder extends StatelessWidget {
  final DateTime date;

  final List<CalendarEventData> events;

  final StringProvider? dateStringBuilder;

  final bool shouldHighlight;

  final Color backgroundColor;

  final Color highlightColor;

  final Color tileColor;

  final TileTapCallback? onTileTap;

  final TileTapCallback? onTileLongTap;

  final TileTapCallback? onTileDoubleTap;

  final bool isInMonth;

  final double highlightRadius;

  final Color titleColor;

  final Color highlightedTitleColor;

  final bool hideDaysNotInMonth;

  const MonthCellBuilder({
    super.key,
    required this.date,
    required this.events,
    this.isInMonth = false,
    this.hideDaysNotInMonth = true,
    this.shouldHighlight = false,
    this.backgroundColor = Colors.blue,
    this.highlightColor = Colors.blue,
    this.onTileTap,
    this.onTileLongTap,
    this.tileColor = Colors.blue,
    this.highlightRadius = 11,
    this.titleColor = Colors.black,
    this.highlightedTitleColor = Colors.white,
    this.dateStringBuilder,
    this.onTileDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          if (!(!isInMonth && hideDaysNotInMonth))
            CircleAvatar(
              radius: highlightRadius,
              backgroundColor:
                  shouldHighlight ? highlightColor : Colors.transparent,
              child: Text(
                dateStringBuilder?.call(date) ?? "${date.day}",
                style: TextStyle(
                  color: shouldHighlight
                      ? highlightedTitleColor
                      : isInMonth
                          ? titleColor
                          : titleColor.withOpacity(0.4),
                  fontSize: 12,
                ),
              ),
            ),
          if (events.isNotEmpty)
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      events.length,
                      (index) => InkWell(
                        onTap: () {},
                        onLongPress: () =>
                            onTileLongTap?.call(events[index], date),
                        onDoubleTap: () =>
                            onTileDoubleTap?.call(events[index], date),
                        child: eventBox(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget eventBox(int index) {
    final bgColor = events[index].color;
    return Container(
      decoration: BoxDecoration(
          color: bgColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4.0),
          border: Border(left: BorderSide(color: bgColor, width: 6))),
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 2),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Text(
              events[index].title,
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: events[index].titleStyle ??
                  TextStyle(
                    color: bgColor,
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
