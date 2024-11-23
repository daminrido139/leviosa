import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/chat_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/chat/levi_chat_box.dart';
import 'package:leviosa/widgets/common/default_dp.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 60,
          backgroundColor: Colors.white,
          leading: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: DefaultDp(name: "Sachita", size: 40),
          ),
          title: const Text(
            'Chats',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            searchBox(),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                  stream: ChatServices.listenChats(AuthService.getUserId()),
                  builder: (context, snapshots) {
                    if (snapshots.hasError) {
                      return Center(child: Text(snapshots.error.toString()));
                    }
                    if (snapshots.hasData) {
                      final snap = snapshots.data!.docs;
                      return ListView.builder(
                          key: UniqueKey(),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            final doc = snap[index];
                            final messageData = doc.data();

                            return LeviChatBox(
                              subTitle: messageData['lastMessage'] ?? "",
                              time: timestampTohhmmm(
                                  messageData['lastMessageTime']),
                              count: messageData['count'].toString(),
                              senderId: AuthService.getUserId(),
                              seen: messageData['seen'] ?? false,
                              lastMessageUid:
                                  messageData["lastMessageUID"] ?? "",
                              receiverId: doc.id,
                            );
                          });
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ));
  }

  Widget searchBox() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          canRequestFocus: false,
          onTap: () => context.push(RouterConstants.chatSearchPage),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black),
              ),
              prefixIcon: const Icon(Icons.search),
              hintText: "Search"),
        ));
  }
}
