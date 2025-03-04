import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/chat_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/chat/levi_chat_bubble.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class ChatRoom extends StatefulWidget {
  final String receiverUid;
  final String receiverName;
  final DefaultDp leading;
  const ChatRoom({
    super.key,
    required this.receiverUid,
    required this.receiverName,
    required this.leading,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool isMyReply = false;
  String? replyTo;
  bool showScrollDownBtn = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    ChatServices.setCountZero(AuthService.getUserId(), widget.receiverUid);
    ChatServices.setMessageSeenAtChatInfo(
        widget.receiverUid, AuthService.getUserId());
    super.initState();
  }

  void scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      // context.read<ChatRoomCubit>().increaseChatFetchLimit();
    }
    if (_scrollController.position.pixels > 60) {
      setShowScrollDownBtn(true);
    } else {
      setShowScrollDownBtn(false);
    }
  }

  void setShowScrollDownBtn(bool val) async {
    if (showScrollDownBtn == val) return;
    setState(() {
      showScrollDownBtn = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(Icons.arrow_back),
            ),
            widget.leading,
          ],
        ),
        title: Text(
          widget.receiverName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/img/chat-bg.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // if (context.watch<ChatRoomCubit>().state.receiverId != null)
              //   _primaryAppBar(),
              // Container(height: 0.5, color: const Color(0xB2A1A1A1)),
              Expanded(child: buildChats()),
              const SizedBox(height: 10),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  replyBox(),
                  if (replyTo != null) const SizedBox(height: 10),
                  buildTextField(),
                  const SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // AppBar _primaryAppBar() {
  //   return AppBar(
  //     leading: const SizedBox.shrink(),
  //     leadingWidth: 30,
  //     elevation: 8,
  //     scrolledUnderElevation: 0,
  //     shadowColor: Colors.transparent,
  //     toolbarHeight: 80,
  //     titleSpacing: 0,
  //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //     surfaceTintColor: Colors.transparent,
  //     title: BlocBuilder<SelectedChatsCubit, Map<String, dynamic>>(
  //       builder: (context, state) {
  //         if (state.isEmpty) {
  //           return Row(
  //             children: [
  //               DefaultDp(
  //                 name: context.watch<ChatRoomCubit>().state.receiverName ?? "",
  //                 dpUrl: context.watch<ChatRoomCubit>().state.dpUrl,
  //                 size: 49,
  //               ),
  //               const SizedBox(width: 14),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   LeviosaText(
  //                     context.read<ChatRoomCubit>().state.receiverName ?? "",
  //                     style: GoogleFonts.inter(
  //                       color: isLightMode(context)
  //                           ? const Color(0xFF4D4D4D)
  //                           : const Color(0xFFF6F8F7),
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       LeviosaText(
  //                         ChatServices.formatLastSeen(
  //                             context.read<ChatRoomCubit>().state.lastSeen),
  //                         style: GoogleFonts.inter(
  //                           color: isLightMode(context)
  //                               ? const Color(0xFF4D4D4D)
  //                               : const Color(0xFFF2F5F3),
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                       const SizedBox(width: 4),
  //                       if (ChatServices.isActive(
  //                           context.read<ChatRoomCubit>().state.lastSeen))
  //                         const DecoratedBox(
  //                           decoration: ShapeDecoration(
  //                             shape: CircleBorder(),
  //                             color: Color(0xFF38E25D),
  //                           ),
  //                           child: SizedBox(
  //                             width: 8,
  //                             height: 8,
  //                           ),
  //                         ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           );
  //         }
  //         return LeviosaText(
  //           "${state.length} Selected",
  //           style: GoogleFonts.inter(
  //             color: isLightMode(context)
  //                 ? const Color.fromRGBO(12, 12, 12, 1)
  //                 : Colors.white,
  //             fontSize: 22,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         );
  //       },
  //     ),
  //     actions: [
  //       // IconButton(
  //       //     onPressed: () {
  //       //       context.read<ChatRoomCubit>().setSelectingChats(true);
  //       //     },
  //       //     icon: Image.asset("assets/img/chats/group.png")),
  //       // const SizedBox(width: 20),
  //       LicaIconBtn(
  //         path: "assets/img/chats/bookmark.png",
  //         color: isLightMode(context)
  //             ? const Color.fromRGBO(73, 73, 73, 1)
  //             : const Color.fromRGBO(191, 191, 191, 1),
  //         onTap: () {},
  //       ),
  //       const SizedBox(width: 20),
  //       LicaIconBtn(
  //         path: "assets/img/chats/search.png",
  //         color: isLightMode(context)
  //             ? const Color.fromRGBO(73, 73, 73, 1)
  //             : const Color.fromRGBO(191, 191, 191, 1),
  //         onTap: () {},
  //       ),
  //       const SizedBox(width: 20),
  //       PopupMenuButton(
  //           offset: const Offset(20, 50),
  //           style: ButtonStyle(
  //               textStyle: WidgetStatePropertyAll(
  //             GoogleFonts.inter(
  //               color: isLightMode(context)
  //                   ? const Color.fromRGBO(95, 95, 95, 1)
  //                   : const Color.fromRGBO(229, 229, 229, 1),
  //               fontSize: 12,
  //               fontWeight: FontWeight.w500,
  //               letterSpacing: 0.12,
  //             ),
  //           )),
  //           color:
  //               isLightMode(context) ? Colors.white : const Color(0xFF171717),
  //           icon: const Icon(Icons.more_horiz),
  //           itemBuilder: (context) => [
  //                 popupActionBox(
  //                   Image.asset("assets/img/chats/mute.png"),
  //                   const LeviosaText(
  //                     'Mute Notifications',
  //                   ),
  //                 ),
  //                 popupActionBox(
  //                     Image.asset("assets/img/chats/export.png"),
  //                     const LeviosaText(
  //                       'Export Chat',
  //                     ), onTap: () {
  //                   ChatServices.exportChat(
  //                       context: context,
  //                       senderId: AuthService.getUserId(),
  //                       receiverId:
  //                           context.read<ChatRoomCubit>().state.receiverId!);
  //                 }),
  //                 popupActionBox(
  //                     Image.asset("assets/img/chats/clear.png"),
  //                     const LeviosaText(
  //                       'Clear history',
  //                     ), onTap: () {
  //                   ChatServices.clearChatHistory(AuthService.getUserId(),
  //                       context.read<ChatRoomCubit>().state.receiverId!);
  //                 }),
  //                 popupActionBox(
  //                     Image.asset("assets/img/chats/delete.png"),
  //                     LeviosaText(
  //                       'Delete Chat',
  //                       style: GoogleFonts.inter(
  //                         color: const Color(0xFFEF5C6A),
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w500,
  //                         letterSpacing: 0.12,
  //                       ),
  //                     ),
  //                     trailing: LeviosaText(
  //                       'delete',
  //                       style: GoogleFonts.inter(
  //                         color: const Color(0xFF999999),
  //                         fontSize: 11,
  //                         fontWeight: FontWeight.w500,
  //                         letterSpacing: -0.11,
  //                       ),
  //                     ), onTap: () {
  //                   ChatServices.deleteAllChats(
  //                       context,
  //                       AuthService.getUserId(),
  //                       context.read<ChatRoomCubit>().state.receiverId!);
  //                 }),
  //               ]),
  //       const SizedBox(width: 20),
  //     ],
  //   );
  // }

  // PopupMenuEntry popupActionBox(
  //   Widget leading,
  //   Widget title, {
  //   Widget? trailing,
  //   void Function()? onTap,
  // }) {
  //   return PopupMenuItem(
  //     onTap: onTap ?? () {},
  //     child: Row(
  //       children: [
  //         const SizedBox(width: 10),
  //         leading,
  //         const SizedBox(width: 10),
  //         title,
  //         const Spacer(),
  //         trailing ?? const SizedBox.shrink(),
  //         const SizedBox(width: 10),
  //       ],
  //     ),
  //   );
  // }

  Widget buildChats() {
    return StreamBuilder(
      stream: ChatServices.receiveMessage(
        AuthService.getUserId(),
        widget.receiverUid,
        15,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: LeviosaText(snapshot.error.toString()));
        }

        if (snapshot.hasData) {
          // ChatServices.setCountZero(AuthService.getUserId(),
          //     context.read<ChatRoomCubit>().state.receiverId!);

          final docs = snapshot.data!.docs;
          for (final doc in docs) {
            final data = doc.data();
            if (data["sender_id"] == widget.receiverUid &&
                data["seen"] == false) {
              ChatServices.setMessageSeen(
                doc.id,
                AuthService.getUserId(),
                widget.receiverUid,
              );
            }
          }

          // DateTime? prevMessageDateTime;
          // DateTime? tempMessageDateTime;
          // bool showDate = false;

          return Stack(
            children: [
              ListView.builder(
                  cacheExtent: 9999,
                  controller: _scrollController,
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data();
                    final alignment =
                        data["sender_id"] == AuthService.getUserId()
                            ? Alignment.centerRight
                            : Alignment.centerLeft;
                    // final Map<String, dynamic> reactionData =
                    //     data["reactions"] ?? {};
                    // final reaction = reactionData.values.toList();
                    // reaction.removeWhere((e) => e == null);
                    // showDate = (prevMessageDateTime == null)
                    //     ? false
                    //     : !isSameDay(
                    //         prevMessageDateTime!,
                    //         (data["time"] as Timestamp).toDate(),
                    //       );
                    // tempMessageDateTime = prevMessageDateTime;
                    // prevMessageDateTime = (data["time"] as Timestamp).toDate();
                    return LeviChatBubble(
                      key: Key(docs[index].id.toString()),
                      receiverId: widget.receiverUid,
                      replyTo: data["reply_to"] as String?,
                      message: data["message"] as String,
                      messageId: docs[index].id,
                      isCurrentUser: alignment == Alignment.centerRight,
                      time: timestampTohhmmm(data["time"]),
                      isSeen: data["seen"] ?? false,
                      isMyReply: data["is_my_reply"] ?? true,
                      receiverName: widget.receiverName,
                    );
                    // return Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     if (index == docs.length - 1)
                    //       // Padding(
                    //       //   padding: const EdgeInsets.only(top: 100.0),
                    //       //   child: ChatViewTimeWidget(
                    //       //     dateTime: prevMessageDateTime!,
                    //       //   ),
                    //       // ),
                    //       LeviChatBubble(
                    //         key: Key(docs[index].id.toString()),
                    //         receiverId: widget.receiverUid,
                    //         replyTo: data["reply_to"] as String?,
                    //         message: data["message"] as String?,
                    //         messageId: docs[index].id,
                    //         isCurrentUser: alignment == Alignment.centerRight,
                    //         time: timestampTohhmmm(data["time"]),
                    //         isSeen: data["seen"] ?? false,
                    //         isMyReply: data["is_my_reply"] ?? true,
                    //         receiverName: widget.receiverName,
                    //       ),
                    //     // if (showDate)
                    //     //   ChatViewTimeWidget(
                    //     //     dateTime: tempMessageDateTime!,
                    //     //   ),
                    //   ],
                    // );
                  }),
              Positioned(
                right: 4,
                bottom: 4,
                child: Visibility(
                  visible: showScrollDownBtn,
                  child: scrollDownButton(),
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget scrollDownButton() {
    return Material(
      color: const Color.fromRGBO(43, 82, 120, 0.8),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: () {
          if (_scrollController.position.pixels < 500) {
            _scrollController.animateTo(
              0,
              duration: Durations.medium2,
              curve: Curves.fastEaseInToSlowEaseOut,
            );
          } else {
            _scrollController.jumpTo(0);
          }
        },
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget replyBox() {
    return AnimatedSize(
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: Durations.medium4,
      child: (replyTo == null)
          ? const SizedBox.shrink()
          : Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isLightMode(context)
                          ? Colors.white
                          : Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 10),
                          LeviosaText(
                            isMyReply ? 'You' : widget.receiverName,
                            style: TextStyle(
                              fontSize: 16,
                              color: isLightMode(context)
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          LeviosaText(replyTo!,
                              style: TextStyle(
                                fontSize: 16,
                                color: isLightMode(context)
                                    ? const Color.fromARGB(255, 12, 12, 12)
                                    : const Color.fromRGBO(245, 245, 245, 1),
                              )),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      replyTo = null;
                    });
                  },
                  icon: (replyTo == null)
                      ? const SizedBox.shrink()
                      : const Icon(Icons.close),
                ),
                const SizedBox(width: 10),
              ],
            ),
    );
  }

  Widget buildTextField() {
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(child: leviTextField()),
        const SizedBox(width: 8),
        sendBtn(),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget leviTextField() {
    return TextField(
      cursorHeight: 20,
      cursorColor: isLightMode(context)
          ? const Color.fromRGBO(12, 12, 12, 1)
          : Colors.white,
      style: TextStyle(
        color: isLightMode(context)
            ? const Color.fromRGBO(12, 12, 12, 1)
            : Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.1,
      ),
      controller: _messageController,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Start Typing...',
        hintStyle: const TextStyle(
            color: Color.fromRGBO(151, 151, 151, 1),
            fontSize: 20,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 233, 223, 190)),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 233, 223, 190)),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 233, 223, 190)),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void onSendBtnClicked() async {
    if (_messageController.text.trim().isNotEmpty) {
      ChatServices.sendMessage(
        AuthService.getUserId(),
        widget.receiverUid,
        context.read<UserCubit>().state.name,
        _messageController.text.trim(),
        replyTo,
        isMyReply,
      );
    }

    setState(() {
      _messageController.text = "";

      replyTo = null;
    });
  }

  Widget sendBtn() {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: Color.fromARGB(255, 233, 223, 190),
      ),
      child: IconButton(
          onPressed: onSendBtnClicked,
          icon: Icon(
            Icons.send,
            size: 28,
            color: isLightMode(context)
                ? const Color.fromRGBO(73, 73, 73, 1)
                : const Color.fromRGBO(191, 191, 191, 1),
          )),
    );
  }
}
