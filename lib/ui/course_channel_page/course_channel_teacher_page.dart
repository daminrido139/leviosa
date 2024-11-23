import 'package:flutter/material.dart';
import 'package:leviosa/widgets/course/course_box.dart';

class CourseChannelTeacherPage extends StatelessWidget {
  const CourseChannelTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.book),
            SizedBox(width: 10),
            Text('Course'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: searchBar(),
          ),
          ////////////////////////////////
          const CourseBox(),
        ],
      ),
    );
  }

  Widget searchBar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 4),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Search Course',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
