import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/default_dp.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffad9c00)),
              ),
              hintText: "Search"),
        ));
  }
}
