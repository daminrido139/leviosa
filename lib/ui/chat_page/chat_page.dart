import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/chat_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/ui/drawer_page/drawer_page.dart';
import 'package:leviosa/widgets/chat/levi_chat_box.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/leviosa_button.dart';
import 'package:leviosa/widgets/common/leviosa_form_field.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final calling = TextEditingController();
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void dispose() {
    calling.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      drawer: const DrawerPage(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 56,
        backgroundColor: Colors.white,
        foregroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              DefaultDp(name: context.read<UserCubit>().state.name, size: 40),
            ],
          ),
        ),
        title: searchBox(),
      ),
      body: topIcons(),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const SizedBox(height: 10),
      //     topIcons(),
      //     const SizedBox(height: 10),
      //     // Expanded(
      //     //   child: StreamBuilder(
      //     //       stream: ChatServices.listenChats(AuthService.getUserId()),
      //     //       builder: (context, snapshots) {
      //     //         if (snapshots.hasError) {
      //     //           return Center(
      //     //               child: LeviosaText(snapshots.error.toString()));
      //     //         }
      //     //         if (snapshots.hasData) {
      //     //           final snap = snapshots.data!.docs;
      //     //           return ListView.builder(
      //     //               cacheExtent: 9999,
      //     //               physics: const NeverScrollableScrollPhysics(),
      //     //               shrinkWrap: true,
      //     //               itemCount: snap.length,
      //     //               itemBuilder: (context, index) {
      //     //                 final doc = snap[index];
      //     //                 final messageData = doc.data();

      //     //                 return LeviChatBox(
      //     //                   key: Key(doc.id),
      //     //                   subTitle: messageData['lastMessage'] ?? "",
      //     //                   time: timestampTohhmmm(
      //     //                       messageData['lastMessageTime']),
      //     //                   count: messageData['count'].toString(),
      //     //                   senderId: AuthService.getUserId(),
      //     //                   seen: messageData['seen'] ?? false,
      //     //                   lastMessageUid: messageData["lastMessageUID"] ?? "",
      //     //                   receiverId: doc.id,
      //     //                 );
      //     //               });
      //     //         }

      //     //         return const Center(
      //     //           child: CircularProgressIndicator(),
      //     //         );
      //     //       }),
      //     // )
      //   ],
      // ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.push(RouterConstants.leviosaChatBot);
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 243, 227, 173),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("assets/img/chatbot_15320513.png"),
                ),
              ),
            ),
          ),
          ///////////////////////////////////////////////////////////////
          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              context.push(RouterConstants.avatarAiPage);
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 243, 227, 173),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.person_2_outlined,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget topIcons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ////////////////////////////////////////////////////////////////////////
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: leviosaColor.withOpacity(0.6),
                fixedSize: const Size(200, 80)),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          LeviosaFormField(
                            title: 'એક આઈડી દાખલ કરો',
                            hintText: "કૃપા કરીને એક અનન્ય આઈડી દાખલ કરો",
                            controller: calling,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LeviosaButton(
                            width: 120,
                            height: 40,
                            child: const LeviosaText(
                              "મુલાકાતમાં જોડાઓ",
                              style: TextStyle(
                                  color: Colors.black,
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
                            height: 10,
                          )
                        ],
                      ),
                    ));
                  });
            },
            child: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.link,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(
                  width: 5,
                ),
                LeviosaText(
                  "બેઠક",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
          ///////////////////////////////////////////////////////////////////////////
          const SizedBox(
            height: 100,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: leviosaColor.withOpacity(0.6),
                fixedSize: const Size(200, 80)),
            onPressed: () {
              context.push(RouterConstants.textToSign);
            },
            child: const Icon(
              Icons.translate,
              color: Colors.black,
              size: 60,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          /////////////////////////////////////////////
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: leviosaColor.withOpacity(0.6),
                fixedSize: const Size(200, 80)),
            onPressed: () {
              context.push(RouterConstants.signToText);
            },
            child: const Icon(
              Icons.emoji_people_outlined,
              color: Colors.black,
              size: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return TextField(
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
    );
  }
}
