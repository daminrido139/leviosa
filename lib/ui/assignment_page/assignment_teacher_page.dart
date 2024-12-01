import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/router_constants.dart';
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
  late final TabController tabController;
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(onTabChange);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onTabChange() {
    if (tabController.index != currentIndex) {
      setState(() {
        currentIndex = tabController.index;
      });
    }
  }

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
          IconButton(
            onPressed: () => context.push(RouterConstants.newAssignmentPage),
            icon: const Icon(Icons.note_add_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          PreferredSize(
            preferredSize: const Size(200.0, 200.0),
            child: SizedBox(
              child: TabBar(
                splashFactory: NoSplash.splashFactory,
                controller: tabController,
                // padding: EdgeInsets.symmetric(horizontal: 28, vertical: 4),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.black,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Container(
                      height: 45,
                      // width: 88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tabController.index == 0
                            ? const Color.fromARGB(255, 233, 223, 190)
                            : const Color.fromARGB(255, 236, 234, 234),
                      ),
                      child: const Center(
                        child: LeviosaText(
                          "Forthcoming",
                        ),
                      ),
                    ),
                    // text: "Forthcoming",
                  ),
                  Tab(
                    child: Container(
                      height: 45,
                      // width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tabController.index == 1
                            ? const Color.fromARGB(255, 233, 223, 190)
                            : const Color.fromARGB(255, 236, 234, 234),
                      ),
                      child: const Center(
                        child: LeviosaText(
                          "Past due",
                        ),
                      ),
                    ),
                    // text: "Forthcoming",
                  ),
                  Tab(
                    child: Container(
                      height: 45,
                      // width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tabController.index == 2
                            ? const Color.fromARGB(255, 233, 223, 190)
                            : const Color.fromARGB(255, 236, 234, 234),
                      ),
                      child: const Center(
                        child: LeviosaText(
                          "Completed",
                        ),
                      ),
                    ),
                    // text: "Forthcoming",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                forthcoming(context),
                pastdue(),
                completed()
                // MyPostTab(),
                // MyReelsTab(),
                // MyTagTab(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget forthcoming(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        assignmentcard(
            context,
            "20 Sept",
            "(two days)",
            const Color.fromARGB(255, 243, 163, 97),
            "Assignment -1 (Number)",
            "OC"),
        assignmentcard(
            context,
            "21 Sept",
            "(three days)",
            const Color.fromARGB(255, 243, 208, 102),
            "Assignment -2 (Alphabets)",
            "Mc"),
        assignmentcard(
            context,
            "23 Sept",
            "(four days)",
            const Color.fromARGB(255, 188, 118, 235),
            "Assignment -3 (Colors)",
            "KI"),
        assignmentcard(
            context,
            "24 Sept",
            "(five days)",
            const Color.fromARGB(255, 200, 247, 146),
            "Assignment -4 (Words)",
            "SC"),
      ],
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

  Widget assignmentcard(
      BuildContext context, subtext, txt, color, pretxt, htxt) {
    return InkWell(
      onTap: () {
        context.push(RouterConstants.assignmentStudentDetailedView);
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
