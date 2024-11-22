import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatSearchPage extends StatefulWidget {
  const ChatSearchPage({super.key});

  @override
  State<ChatSearchPage> createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                searchBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
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
        ));
  }
}
