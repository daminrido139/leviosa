import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/ui/assignment_page/assignment_student_page.dart';
import 'package:leviosa/ui/calendar_page/calendar_page.dart';
import 'package:leviosa/ui/chat_page/chat_page.dart';
import 'package:leviosa/ui/course_channel_page/course_channel_parent_page.dart';
import 'package:leviosa/ui/profile_page/profile_parent_page.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class CommonParentPage extends StatefulWidget {
  const CommonParentPage({super.key});

  @override
  State<CommonParentPage> createState() => _CommonParentPageState();
}

class _CommonParentPageState extends State<CommonParentPage> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: const [
          CalendarPage(),
          ChatPage(),
          AssignmentStudentPage(),
          CourseChannelParentPage(),
          ProfileParentPage()
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(color: leviosaColor),
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
                  LeviosaText(
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
                  LeviosaText(
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
                  LeviosaText(
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
                  LeviosaText(
                    "Course",
                    style: TextStyle(
                        fontWeight: selectedPage == 3
                            ? FontWeight.bold
                            : FontWeight.normal),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                selectedPage = 4;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(selectedPage == 4 ? Icons.person : Icons.person_outline),
                  LeviosaText(
                    "Student Profile",
                    style: TextStyle(
                        fontWeight: selectedPage == 4
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
