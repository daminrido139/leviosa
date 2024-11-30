import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/course_service.dart';
import 'package:leviosa/ui/drawer_page/drawer_page.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/course/course_box.dart';
import 'package:leviosa/widgets/course/course_search_bar.dart';

class CourseChannelTeacherPage extends StatefulWidget {
  const CourseChannelTeacherPage({super.key});

  @override
  State<CourseChannelTeacherPage> createState() =>
      _CourseChannelTeacherPageState();
}

class _CourseChannelTeacherPageState extends State<CourseChannelTeacherPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  List<CourseModel> courses = [];

  @override
  void initState() {
    super.initState();
    fetchMyCourses();
  }

  Future<void> fetchMyCourses() async {
    courses = await CourseService.fetchMyTeachingCourses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: const DrawerPage(),
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
        actions: [
          GestureDetector(
            onTap: () => context
                .push(RouterConstants.createCourse)
                .then((_) => fetchMyCourses()),
            child: Container(
              height: 35,
              width: 100,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 243, 227, 173),
                    Color.fromRGBO(228, 212, 156, 1),
                  ], begin: Alignment.topCenter, end: Alignment.bottomLeft),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 5,
                    )
                  ]),
              child: const Center(
                  child: LeviosaText(
                "+ Create",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: CourseSearchBar(),
          ),
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
