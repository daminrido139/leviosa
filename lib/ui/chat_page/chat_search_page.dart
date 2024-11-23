import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/user_service.dart';
import 'package:leviosa/widgets/chat/new_chat_box.dart';
import 'package:leviosa/widgets/common/default_dp.dart';

class ChatSearchPage extends StatefulWidget {
  const ChatSearchPage({super.key});

  @override
  State<ChatSearchPage> createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  final FocusNode _focusNode = FocusNode();
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];

  @override
  void initState() {
    loadUsers();
    _focusNode.requestFocus();
    super.initState();
  }

  void loadUsers() async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await UserService.getAllUsers();
    users.addAll(data.docs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 5),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(child: searchBox()),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final doc = users[index];
                // if (doc.id == AuthService.getUserId()) {
                //   return const SizedBox.shrink();
                // }
                final data = doc.data();
                if (data['name'] == null) {
                  return const SizedBox.shrink();
                }
                return NewChatBox(
                  leading: DefaultDp(
                    name: data['name'],
                    dpUrl: data['profileUrl'],
                    size: 49,
                  ),
                  receiverName: data['name'] ?? "",
                  onTap: () {
                    context.pushReplacement(RouterConstants.chatRoom, extra: {
                      "receiver_name": data['name'] ?? "",
                      "receiver_uid": doc.id,
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Color(0xffad9c00),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Color(0xffad9c00),
              ),
            ),
            hintText: "Search"),
      ),
    );
  }
}
