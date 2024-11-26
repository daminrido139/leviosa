// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/model/user_model.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/chat_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/services/user_service.dart';
import 'package:leviosa/widgets/common/default_dp.dart';

class LeviChatBox extends StatefulWidget {
  final String subTitle;
  final String time;
  final String count;
  final String senderId;
  final String receiverId;
  final String lastMessageUid;
  final bool seen;
  const LeviChatBox({
    super.key,
    required this.subTitle,
    required this.time,
    required this.count,
    required this.senderId,
    required this.receiverId,
    required this.seen,
    required this.lastMessageUid,
  });

  @override
  State<LeviChatBox> createState() => _LeviChatBoxState();
}

class _LeviChatBoxState extends State<LeviChatBox> {
  Widget? leading;
  String? name;

  @override
  void initState() {
    fetchUserDetails();
    super.initState();
  }

  void fetchUserDetails() async {
    final UserModel? userCache = ChatServices.getUserCache(widget.receiverId);
    if (userCache == null) {
      final userDetails = await UserService.getUserData(widget.receiverId);
      leading = DefaultDp(
        name: userDetails!.name,
        size: 49,
        dpUrl: userDetails.profilePicture,
      );
      name = userDetails.name;
      ChatServices.cacheUser(
        widget.receiverId,
        userDetails,
      );
    } else {
      leading = DefaultDp(
        name: userCache.name,
        size: 49,
        dpUrl: userCache.profilePicture,
      );
      name = userCache.name;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, left: 4, right: 4),
      child: ListTile(
        minTileHeight: 76,
        onTap: () async {
          if (name == null || leading == null) return;
          await Future.delayed(Durations.medium1);
          context.push(RouterConstants.chatRoom, extra: {
            "receiver_name": name,
            "leading": leading,
            "receiver_uid": widget.receiverId,
          });
        },
        leading: leading ?? const DefaultDp(name: "", size: 49),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name ?? "",
                style: TextStyle(
                  color: isLightMode(context)
                      ? const Color(0xFF4D4D4D)
                      : const Color(0xFFF6F8F7),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                color: isLightMode(context)
                    ? const Color(0xFF7D7D7D)
                    : const Color(0xFF7D7D7D),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            if (widget.lastMessageUid == widget.senderId) ...[
              widget.seen
                  ? const Icon(Icons.check, color: Colors.blue, size: 15)
                  : const Icon(Icons.check, color: Colors.grey, size: 15),
              const SizedBox(width: 4)
            ],
            Expanded(
              child: Text(
                widget.subTitle,
                style: TextStyle(
                  color: isLightMode(context)
                      ? const Color(0xFF4D4D4D)
                      : const Color(0xFFF2F5F3),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.count != '0')
              Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                decoration: const ShapeDecoration(
                  color: Color.fromRGBO(203, 193, 100, 1),
                  shape: CircleBorder(),
                ),
                child: Text(
                  widget.count,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 18, 0),
      ),
    );
  }
}
