import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/default_dp.dart';

class AnnouncementTile extends StatelessWidget {
  final String? dpUrl;
  final String name;
  final String message;
  final String timestamp;
  final VoidCallback? onTap;

  const AnnouncementTile({
    super.key,
    required this.dpUrl,
    required this.name,
    required this.message,
    required this.timestamp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultDp(name: name, size: 49, dpUrl: dpUrl),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        timestamp,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}
