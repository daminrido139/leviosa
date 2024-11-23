import 'package:flutter/material.dart';
import 'package:leviosa/ui/drawer_page/drawer_page.dart';

import 'package:leviosa/widgets/common/default_dp.dart';

class CoursestudentPage extends StatefulWidget {
  const CoursestudentPage({super.key});

  @override
  State<CoursestudentPage> createState() => _CoursestudentPageState();
}

class _CoursestudentPageState extends State<CoursestudentPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final calling = TextEditingController();
  @override
  void dispose() {
    calling.dispose();
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
          child: const Row(
            children: [
              SizedBox(
                width: 15,
              ),
              DefaultDp(name: "Sachita", size: 40),
            ],
          ),
        ),
        title: const Text(
          'Course',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
