import 'package:flutter/material.dart';
import 'package:leviosa/model/course_model.dart';

class CourseStudentPage extends StatefulWidget {
  final CourseModel courseModel;
  const CourseStudentPage({super.key, required this.courseModel});

  @override
  State<CourseStudentPage> createState() => _CourseStudentPageState();
}

class _CourseStudentPageState extends State<CourseStudentPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(widget.courseModel.courseName),
    ));
  }
}
