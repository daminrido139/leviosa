import 'package:flutter/material.dart';

class LeviosaEventTile extends StatelessWidget {
  final String title;

  final String? description;

  final Color backgroundColor;

  final int totalEvents;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final BorderRadius borderRadius;

  final TextStyle? titleStyle;

  final TextStyle? descriptionStyle;

  const LeviosaEventTile({
    super.key,
    required this.title,
    this.description,
    required this.backgroundColor,
    required this.totalEvents,
    required this.padding,
    required this.margin,
    required this.borderRadius,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.2),
          borderRadius: borderRadius,
          border: Border(left: BorderSide(color: backgroundColor, width: 6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: titleStyle ??
                  TextStyle(
                    fontSize: 24,
                    color: backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          if (description?.isNotEmpty ?? false)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 20),
                child: Text(
                  description!,
                  style: descriptionStyle ??
                      TextStyle(
                        fontSize: 17,
                        color: backgroundColor,
                      ),
                ),
              ),
            ),
          if (totalEvents > 1)
            Expanded(
              child: Text(
                "+${totalEvents - 1} more",
                style: (descriptionStyle ??
                        TextStyle(
                          color: Colors.grey.shade900,
                        ))
                    .copyWith(fontSize: 17),
              ),
            ),
        ],
      ),
    );
  }
}
