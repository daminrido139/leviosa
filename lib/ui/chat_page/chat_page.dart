import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
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
