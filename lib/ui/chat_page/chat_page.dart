import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/chat_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/chat/levi_chat_box.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/leviosa_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final calling = TextEditingController();
  @override
  void dispose() {
    calling.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 60,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child:
                DefaultDp(name: context.read<UserCubit>().state.name, size: 40),
          ),
          title: const Text(
            'Chats',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push(RouterConstants.textToSign);
              },
              icon: const Icon(
                Icons.text_fields_outlined,
                color: Color.fromRGBO(228, 212, 156, 1),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {},
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/img/videocall1.webp"),
              ),
            ),
            const SizedBox(
              width: 25,
            )
          ],
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: Container(
                        height: 200,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 233, 223, 190),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Call id:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: calling,
                                decoration: const InputDecoration(
                                    hintText: "Please Enter call id",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const Spacer(),
                            LeviosaButton(
                              child: const Text(
                                "Join Meeting",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                context.push(
                                  RouterConstants.videoCallPage,
                                  extra: {
                                    "callId": calling.text,
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ));
                    });
              },
              child: Row(
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(Icons.video_camera_front_outlined),
                  ),
                  Text(
                    "Create a Meet with a Id...",
                    style: TextStyle(color: Colors.blue[100]),
                  ),
                ],
              ),
            ),
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
