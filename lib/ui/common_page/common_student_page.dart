import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/ui/calendar_page/calendar_page.dart';
import 'package:leviosa/ui/chat_page/chat_page.dart';
import 'package:leviosa/ui/course_channel_page/course_channel_student_page.dart';
import 'package:leviosa/ui/job/job_search.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class CommonStudentPage extends StatefulWidget {
  const CommonStudentPage({
    super.key,
  });

  @override
  State<CommonStudentPage> createState() => _HomepageState();
}

class _HomepageState extends State<CommonStudentPage> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: const [
          CalendarPage(),
          ChatPage(),
          JobSearch(),
          CourseChannelStudentPage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 243, 227, 173)),
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
                    "કૅલેન્ડર",
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
                    "ચેટ્સ",
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
                  Icon(selectedPage == 2
                      ? Icons.join_full
                      : Icons.join_inner_outlined),
                  LeviosaText(
                    "નોકરી",
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
                    "કોર્સ",
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
                context.push(RouterConstants.learningPage);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedPage == 4 ? Icons.book : Icons.book_outlined,
                  ),
                  LeviosaText(
                    "શિક્ષણ",
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
