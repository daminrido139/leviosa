import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class AssignmentStudentDetailedView extends StatefulWidget {
  const AssignmentStudentDetailedView(
      {super.key,
      required this.desc,
      required this.assignmentname,
      required this.coursename,
      required this.date,
      required this.time,
      required this.attachments});
  final String assignmentname;
  final String coursename;
  final String date;
  final String time;
  final String desc;

  final List attachments;

  @override
  State<AssignmentStudentDetailedView> createState() =>
      _AssignmentStudentDetailedViewState();
}

class _AssignmentStudentDetailedViewState
    extends State<AssignmentStudentDetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LeviosaText(widget.coursename),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ////////////////////////// Title//////////////
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            widget.assignmentname,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //////////////////////////////////////////////
        /////////////////////time/////////////////////
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            widget.date + widget.time,
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
        Padding(
          padding: EdgeInsets.only(left: 52, right: 8),
          child: LeviosaText(
            maxLines: 500,
            widget.desc,
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
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return referenMaterials();
              }),
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

  Widget referenMaterials() {
    return Padding(
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
    );
  }
}
