import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class AssignmentStudentDetailedView extends StatelessWidget {
  const AssignmentStudentDetailedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LeviosaText('Odd 24-25-U18AUE0014-R12-OFF Road'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ////////////////////////// Title//////////////
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            "Assignment No -01 (Written Assignment)",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //////////////////////////////////////////////
        /////////////////////time/////////////////////
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            "Due 4 November 2024 15:30",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            "Closes 5 November 2024 08:30",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //////////////////////////////////////////////
        ///////////////////////instruction/////////////
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: LeviosaText(
            "Instructions",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            "Dear Students,",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        //////////////////////////////////////////////
        ////////////////////////description///////////
        const Padding(
          padding: EdgeInsets.only(left: 52, right: 8),
          child: LeviosaText(
            maxLines: 500,
            "Kindly use proper A-4 size sheets for writing the assignment and must use both sides of the paper. It is an individual assignment, and each student must submit it separately. This assignment is also taken for evaluation, and all must draw this rubrics table on the first page of the assignment. You need to write your name and roll no. on each page. Need to submit the softcopy of the assignment in MS Teams and the Hard copy in cabin. If the Assignments are submitted without rubrics table or name and roll no. (Each page) or soft copy did not upload in our course MS channels will not validate for Internal CAM Marks.",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        //////////////////////////////////////////////
        ////////////////////////References////////////
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: LeviosaText(
            "References Materials",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/img/doclogo.png")),
                ),
                const Text("Odd 24-25-U18AUE0014-R12-OFF Road.doc"),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: LeviosaText(
            "Points",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText("10 Possible Points"),
        )
        //////////////////////////////////////////////
      ]),
    );
  }
}
