// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/model/assignment_model.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/assignment_services.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/ui/drawer_page/drawer_page.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class AssignmentTeacherPage extends StatefulWidget {
  const AssignmentTeacherPage({super.key});

  @override
  State<AssignmentTeacherPage> createState() => _AssignmentTeacherPageState();
}

class _AssignmentTeacherPageState extends State<AssignmentTeacherPage>
    with SingleTickerProviderStateMixin {
  // late final TabController tabController;
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> key = GlobalKey();
  List<AssignmentModel> assignments = [];

  @override
  void initState() {
    fetchassignments();
    // tabController = TabController(length: 3, vsync: this);
    // tabController.addListener(onTabChange);

    super.initState();
  }

  fetchassignments() async {
    assignments = await AssignmentServices.fetchAssignmentTeacher();
    setState(() {});
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  // void onTabChange() {
  //   if (tabController.index != currentIndex) {
  //     setState(() {
  //       currentIndex = tabController.index;
  //     });
  //   }
  // }

  int index = 0;
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
            'Assignments',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () => context.push(RouterConstants.newAssignmentPage),
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
        body: forthcoming(context));
  }

  Widget forthcoming(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 20),
        ListView.builder(
            itemCount: assignments.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return assignmentcard(
                  context,
                  assignments[index].dueDate.split("&#")[1],
                  "(few days)",
                  const Color.fromARGB(255, 243, 163, 97),
                  assignments[index].heading,
                  "OC",
                  assignments[index].heading,
                  assignments[index].courseName,
                  assignments[index].desc,
                  assignments[index].dueDate,
                  assignments[index].dueDate,
                  assignments[index].attachments);
            }),
      ]),
    );
  }

  Widget pastdue() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
        ),
        LeviosaText("NO Past Due Assignment")
      ],
    );
  }

  Widget completed() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
        ),
        LeviosaText("Not yet Complete")
      ],
    );
  }

  Widget assignmentcard(BuildContext context, subtext, txt, color, pretxt, htxt,
      assignmentname, coursename, desc, date, time, attachments) {
    return InkWell(
      onTap: () {
        context.push(RouterConstants.assignmentStudentDetailedView, extra: {
          "assignmentname": assignmentname,
          "coursename": coursename,
          "desc": desc,
          "date": date,
          "time": time,
          "attachments": attachments,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: LeviosaText(
                  subtext,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
                child: LeviosaText(
                  txt,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: LeviosaText(htxt)),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      LeviosaText(
                        pretxt,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
