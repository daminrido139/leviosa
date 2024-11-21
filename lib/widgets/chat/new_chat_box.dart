import 'package:flutter/material.dart';

class NewChatBox extends StatelessWidget {
  final Widget leading;
  final String receiverName;
  final String? receiverId;
  final void Function() onTap;
  const NewChatBox({
    super.key,
    required this.leading,
    this.receiverId,
    required this.receiverName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListTile(
        onTap: onTap,
        minTileHeight: 74,
        leading: leading,
        title: Text(
          receiverName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
