import 'package:flutter/material.dart';
import 'package:leviosa/ui/calendar_page/calendar_page.dart';
import 'package:leviosa/ui/chat_page/chat_page.dart';
import 'package:leviosa/ui/course_channel_page/course_channel_page.dart';
import 'package:leviosa/ui/profile_page/profile_teacher_page.dart';

class CommonTeacherPage extends StatefulWidget {
  const CommonTeacherPage({super.key});

  @override
  State<CommonTeacherPage> createState() => _CommonTeacherPageState();
}

class _CommonTeacherPageState extends State<CommonTeacherPage> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: const [
          ChatPage(),
          CalendarPage(),
          CourseChannelPage(),
          ProfileTeacherPage(),
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
              selectedPage == 1
                  ? Icons.calendar_month
                  : Icons.calendar_month_outlined,
            ),
            label: "Calendar",
          ),
          NavigationDestination(
            icon: Icon(
              selectedPage == 2 ? Icons.book : Icons.book_outlined,
            ),
            label: "Course",
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
