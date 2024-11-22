// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/ui/learning_page.dart/subjectstudents_page.dart';

class Learningpage extends StatelessWidget {
  const Learningpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
        elevation: 0,
        toolbarHeight: 50,
        leadingWidth: 30,
        scrolledUnderElevation: 0,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: const Text(
          "Learning section",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemCount: Utility.horizontallst.length,
        itemBuilder: (context, ind) {
          return customhorizontalcard(Utility.horizontallst[ind], ind, context);
        },
      ),
    );
  }

  // SizedBox(
  //   height: 140,
  //   child: ListView.builder(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //       shrinkWrap: true,
  //       scrollDirection: Axis.vertical,
  //       itemCount: horizontallst.length,
  //       itemBuilder: (context, ind) {
  //         return customhorizontalcard(horizontallst[ind], ind);
  //       }),
  // ),

  customhorizontalcard(imgurl, ind, BuildContext context) {
    String level = (ind + 1).toString();
    return InkWell(
      onTap: () {
        context.push(RouterConstants.subjectPage);
      },
      child: Stack(
        children: [
          Container(
            decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 33, 39, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(imgurl),
            ),
          ),
          Center(
            child: Text(
              "CLASS $level",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
