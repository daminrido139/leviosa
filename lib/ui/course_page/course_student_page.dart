import 'package:flutter/material.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

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
      title: LeviosaText(widget.courseModel.courseName),
    ));
  }
}
