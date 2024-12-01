import 'package:flutter/material.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/ui/announcement_page/announcement_student_page.dart';

class CourseStudentPage extends StatefulWidget {
  final CourseModel course;
  const CourseStudentPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseStudentPage> createState() => _CourseStudentPageState();
}

class _CourseStudentPageState extends State<CourseStudentPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.course.courseName),
      ),
      body: Column(
        children: [
          TabBar(
            labelColor: const Color.fromRGBO(135, 111, 34, 1),
            unselectedLabelColor: Colors.grey.shade700,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            indicatorColor: const Color.fromRGBO(135, 111, 34, 1),
            overlayColor:
                const WidgetStatePropertyAll(Color.fromRGBO(135, 111, 34, 0.1)),
            tabs: const <Tab>[
              Tab(
                text: 'Announcement',
                icon: Icon(Icons.announcement_outlined),
              ),
              Tab(
                text: 'Study',
                icon: Icon(Icons.library_books_outlined),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AnnouncementStudentPage(course: widget.course),
                Container(color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
