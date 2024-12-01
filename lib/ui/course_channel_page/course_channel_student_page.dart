import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/services/course_service.dart';
import 'package:leviosa/ui/drawer_page/drawer_page.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/course/course_box.dart';
import 'package:leviosa/widgets/course/course_search_bar.dart';

class CourseChannelStudentPage extends StatefulWidget {
  const CourseChannelStudentPage({super.key});

  @override
  State<CourseChannelStudentPage> createState() =>
      _CourseChannelStudentPageState();
}

class _CourseChannelStudentPageState extends State<CourseChannelStudentPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  List<CourseModel> courses = [];

  @override
  void initState() {
    super.initState();
    fetchMyCourses();
  }

  Future<void> fetchMyCourses() async {
    courses = await CourseService.fetchMyLearningCourses();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: const DrawerPage(),
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              DefaultDp(name: context.read<UserCubit>().state.name, size: 40),
            ],
          ),
        ),
        title: const LeviosaText(
          'Course',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: CourseSearchBar(),
          ),
          ////////////////////////////////
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CourseBox(
                  courseModel: courses[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
