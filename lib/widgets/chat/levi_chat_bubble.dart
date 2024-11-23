import 'package:flutter/material.dart';
import 'package:leviosa/services/common_services.dart';

class LeviChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSeen;
  final String? replyTo;
  final String messageId;
  final String receiverId;
  final bool isCurrentUser;
  final bool isMyReply;
  final String receiverName;
  const LeviChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isSeen,
    required this.isCurrentUser,
    required this.replyTo,
    required this.messageId,
    required this.receiverId,
    required this.isMyReply,
    required this.receiverName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: _constrainedChatBubble(context),
    );
  }

  Widget _timeAndSeenStatusWidget(BuildContext context) {
    return Positioned(
      right: 2,
      bottom: 4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isLightMode(context)
                  ? (isCurrentUser)
                      ? Colors.black45
                      : const Color.fromRGBO(208, 209, 219, 1)
                  : (isCurrentUser)
                      ? const Color(0xFFA6A6A6)
                      : const Color(0xFF646464),
            ),
          ),
          const SizedBox(width: 4),
          (isCurrentUser)
              ? isSeen
                  ? const Icon(Icons.check, color: Colors.blue, size: 14)
                  : const Icon(Icons.check, color: Colors.black45, size: 14)
              : const SizedBox(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _constrainedChatBubble(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 100),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  gradient: isCurrentUser
                      ? const LinearGradient(
                          colors: [
                            Color.fromRGBO(228, 212, 156, 1),
                            Color(0xffad9c00),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                  shape: RoundedRectangleBorder(
                      side: (isCurrentUser)
                          ? BorderSide.none
                          : isLightMode(context)
                              ? const BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(197, 197, 197, 1),
                                )
                              : BorderSide.none,
                      borderRadius: BorderRadius.circular(16)),
                  color: isCurrentUser ? null : Colors.white,
                  shadows: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.067),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///////////////////Message/////////////////
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ).copyWith(
                          fontFamilyFallback: const ['Apple Color Emoji'],
                        ),
                      ),
                    ),
                    //////////////////////////////////////////////////////////////////////////
                    const SizedBox(height: 18)
                  ],
                ),
              ),
            ),
            _timeAndSeenStatusWidget(context),
          ],
        ),
      ],
    );
  }
}
