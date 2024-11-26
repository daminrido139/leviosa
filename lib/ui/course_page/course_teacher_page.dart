import 'package:flutter/material.dart';
import 'package:leviosa/model/course_model.dart';

class CourseTeacherPage extends StatefulWidget {
  final CourseModel? courseModel;
  const CourseTeacherPage({
    super.key,
    required this.courseModel,
  });

  @override
  State<CourseTeacherPage> createState() => _CourseTeacherPageState();
}

class _CourseTeacherPageState extends State<CourseTeacherPage>
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
        title: Text(
            widget.courseModel?.courseName ?? "Linear Algebra - U18EEI5004"),
      ),
      body: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
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
                Container(color: Colors.red),
                Container(color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
