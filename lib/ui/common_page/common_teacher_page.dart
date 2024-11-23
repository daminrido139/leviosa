import 'package:flutter/material.dart';
import 'package:leviosa/ui/calendar_page/calendar_page.dart';
import 'package:leviosa/ui/chat_page/chat_page.dart';
import 'package:leviosa/ui/course_channel_page/course_channel_teacher_page.dart';
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
          CalendarPage(),
          ChatPage(),
          CourseChannelTeacherPage(),
          ProfileTeacherPage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 233, 223, 190)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                selectedPage = 0;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedPage == 0
                        ? Icons.calendar_month
                        : Icons.calendar_month_outlined,
                  ),
                  Text(
                    "Calendar",
                    style: TextStyle(
                        fontWeight: selectedPage == 0
                            ? FontWeight.bold
                            : FontWeight.normal),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                selectedPage = 1;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedPage == 1 ? Icons.message : Icons.message_outlined,
                  ),
                  Text(
                    "Chats",
                    style: TextStyle(
                        fontWeight: selectedPage == 1
                            ? FontWeight.bold
                            : FontWeight.normal),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                selectedPage = 2;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedPage == 2 ? Icons.science : Icons.science_outlined,
                  ),
                  Text(
                    "Assignment",
                    style: TextStyle(
                        fontWeight: selectedPage == 2
                            ? FontWeight.bold
                            : FontWeight.normal),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                selectedPage = 3;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                      selectedPage == 3 ? Icons.school : Icons.school_outlined),
                  Text(
                    "Course",
                    style: TextStyle(
                        fontWeight: selectedPage == 3
                            ? FontWeight.bold
                            : FontWeight.normal),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
