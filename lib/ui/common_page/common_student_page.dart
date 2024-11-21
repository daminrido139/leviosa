import 'package:flutter/material.dart';
import 'package:leviosa/ui/assignment_page/assignment_student_page.dart';
import 'package:leviosa/ui/chat_page/chat_page.dart';
import 'package:leviosa/ui/learning_page.dart/learning_page.dart';
import 'package:leviosa/ui/profile_page/profile_student_page.dart';

class CommonStudentPage extends StatefulWidget {
  const CommonStudentPage({
    super.key,
  });

  @override
  State<CommonStudentPage> createState() => _HomepageState();
}

class _HomepageState extends State<CommonStudentPage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: const [
          ChatPage(),
          AssignmentStudentPage(),
          LearningPage(),
          ProfileStudentPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            selectedPage = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              selectedPage == 0 ? Icons.message : Icons.message_outlined,
            ),
            label: "Chats",
          ),
          NavigationDestination(
            icon: Icon(
              selectedPage == 1 ? Icons.science : Icons.science_outlined,
            ),
            label: "Assignment",
          ),
          NavigationDestination(
            icon: Icon(
              selectedPage == 2 ? Icons.book : Icons.book_outlined,
            ),
            label: "Learning",
          ),
          NavigationDestination(
            icon: Icon(
              selectedPage == 3 ? Icons.person : Icons.person_outline,
            ),
            label: "Profile",
          ),
        ],
        selectedIndex: selectedPage,
      ),
    );
  }
}
