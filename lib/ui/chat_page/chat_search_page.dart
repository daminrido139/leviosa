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
  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchRes = [];

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
    searchRes.addAll(data.docs);
    setState(() {});
  }

  /// Filters and sorts a list of strings based on the search query
  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchEngine(String query) {
    if (query.isEmpty)
      return users; // Return the full list if the query is empty

    String lowerQuery = query.toLowerCase();

    // Sort and filter items
    List<QueryDocumentSnapshot<Map<String, dynamic>>> results =
        users.where((item) {
      return (item.data())["name"].toLowerCase().contains(lowerQuery);
    }).toList()
          ..sort((a, b) {
            // Convert both strings to lowercase for case-insensitive comparison
            String aLower = a.data()["name"].toLowerCase();
            String bLower = b.data()["name"].toLowerCase();

            // Sort based on the position of the query in the string
            int aIndex = aLower.indexOf(lowerQuery);
            int bIndex = bLower.indexOf(lowerQuery);

            // If both have the same index, sort alphabetically
            if (aIndex == bIndex) return aLower.compareTo(bLower);

            // Otherwise, prefer the string with the query appearing earlier
            return aIndex.compareTo(bIndex);
          });

    return results;
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
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              itemCount: searchRes.length,
              itemBuilder: (context, index) {
                final doc = searchRes[index];
                // if (doc.id == AuthService.getUserId()) {
                //   return const SizedBox.shrink();
                // }
                final data = doc.data();
                if (data['name'] == null || data['role'] == 'parent') {
                  return const SizedBox.shrink();
                }
                return NewChatBox(
                  userRole: data['role'],
                  receiverId: doc.id,
                  rollNo: data['rollno'],
                  leading: DefaultDp(
                    name: data['name'],
                    dpUrl: data['profileUrl'],
                    size: 49,
                  ),
                  receiverName: data['name'] ?? "",
                  onTap: () async {
                    await Future.delayed(Durations.medium1);
                    context.pushReplacement(RouterConstants.chatRoom, extra: {
                      "receiver_name": data['name'],
                      "leading": DefaultDp(
                        name: data['name'],
                        dpUrl: data['profileUrl'],
                        size: 49,
                      ),
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
        onChanged: (value) {
          searchRes = searchEngine(value);
          setState(() {});
        },
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
