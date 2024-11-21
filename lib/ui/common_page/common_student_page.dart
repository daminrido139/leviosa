import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';

class CommonStudentPage extends StatefulWidget {
  const CommonStudentPage({
    super.key,
  });

  @override
  State<CommonStudentPage> createState() => _HomepageState();
}

class _HomepageState extends State<CommonStudentPage> {
  int selectedPage = 0;
  final pages = const [
    // Chatpage(),
    // // Speechtotext(),
    // Assignmentpage(),
    // Learningpage(),
    // Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.logout();
                context.go(RouterConstants.signInPage);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: null, //pages[selectedPage],
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
          index: selectedPage,
          height: 75,
          color: const Color.fromARGB(255, 233, 223, 190),
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (val) {
            // setState(() {
            //   selectedPage = val;
            // });
          },
          items: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedPage == 0
                    ? const SizedBox()
                    : const SizedBox(
                        height: 15,
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset("assets/img/home (1).png")),
                ),
                selectedPage == 0 ? const SizedBox() : const Text("Home")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedPage == 1
                    ? const SizedBox()
                    : const SizedBox(
                        height: 15,
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 25,
                      height: 20,
                      child: Image.asset("assets/img/assignment.png")),
                ),
                selectedPage == 1 ? const SizedBox() : const Text("Assignment")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedPage == 2
                    ? const SizedBox()
                    : const SizedBox(
                        height: 15,
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset("assets/img/browser.png")),
                ),
                selectedPage == 2 ? const SizedBox() : const Text("Learning")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedPage == 3
                    ? const SizedBox()
                    : const SizedBox(
                        height: 15,
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset("assets/img/man.png")),
                ),
                selectedPage == 3 ? const SizedBox() : const Text("Profile")
              ],
            ),
          ]),
    );
  }
}
