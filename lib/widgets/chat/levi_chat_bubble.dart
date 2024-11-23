import 'package:flutter/material.dart';
import 'package:leviosa/services/common_services.dart';

class LeviChatBubble extends StatelessWidget {
  final String? message;
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
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 2),
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
                      ? Colors.white
                      : const Color.fromRGBO(208, 209, 219, 1)
                  : (isCurrentUser)
                      ? const Color(0xFFA6A6A6)
                      : const Color(0xFF646464),
            ),
          ),
          const SizedBox(width: 4),
          (isCurrentUser)
              ? isSeen
                  ? const Icon(Icons.check, color: Colors.blue)
                  : const Icon(Icons.check, color: Colors.grey)
              : const SizedBox(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _constrainedChatBubble(BuildContext context) {
    final bool isReplyForMe = isCurrentUser ? isMyReply : !isMyReply;

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
                  shape: RoundedRectangleBorder(
                    side: (isCurrentUser)
                        ? BorderSide.none
                        : isLightMode(context)
                            ? const BorderSide(
                                width: 1,
                                color: Color.fromRGBO(197, 197, 197, 1),
                              )
                            : BorderSide.none,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: (isCurrentUser)
                          ? const Radius.circular(16)
                          : Radius.zero,
                      bottomRight: (isCurrentUser)
                          ? Radius.zero
                          : const Radius.circular(16),
                    ),
                  ),
                  color: isLightMode(context)
                      ? (isCurrentUser ? const Color(0xFF2B5278) : Colors.white)
                      : isCurrentUser
                          ? const Color(0xFF315E8A)
                          : const Color(0xFFDBDBDB),
                  shadows: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.067),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //////////////// reply box  //////////////////////////////////
                      if (replyTo != null)
                        Container(
                          width: (replyTo!.length - 5 <
                                  (message == null ? 0 : message!.length))
                              ? constraints.minWidth
                              : null,
                          margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                          padding: const EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: isCurrentUser
                                  ? BorderSide.none
                                  : (isLightMode(context))
                                      ? const BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(197, 197, 197, 1),
                                        )
                                      : BorderSide.none,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: (isCurrentUser)
                                    ? const Radius.circular(16)
                                    : Radius.zero,
                                bottomRight: (isCurrentUser)
                                    ? Radius.zero
                                    : const Radius.circular(16),
                              ),
                            ),
                            color: isLightMode(context)
                                ? Colors.white
                                : Colors.black,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isReplyForMe ? 'You' : receiverName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isLightMode(context)
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(replyTo!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isLightMode(context)
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ///////////////////Message/////////////////
                      if (message != null)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 12),
                          child: Text(
                            message!,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  (isCurrentUser) ? Colors.white : Colors.black,
                            ).copyWith(
                              fontFamilyFallback: const ['Apple Color Emoji'],
                            ),
                          ),
                        ),
                      //////////////////////////////////////////////////////////////////////////
                      const SizedBox(height: 24)
                    ],
                  );
                }),
              ),
            ),
            _timeAndSeenStatusWidget(context),
          ],
        ),
      ],
    );
  }
}
