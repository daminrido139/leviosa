import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:video_player/video_player.dart';

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

  final List<String> attachments;

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            widget.assignmentname,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //////////////////////////////////////////////
        /////////////////////time/////////////////////
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            widget.time.split("&#")[1].split(" ")[0],
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: LeviosaText(
            widget.time.split("&#")[1].split(" ")[1],
            style: const TextStyle(color: Colors.grey),
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
          padding: const EdgeInsets.only(left: 52, right: 8),
          child: LeviosaText(
            maxLines: 500,
            widget.desc,
            style: const TextStyle(
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
              itemCount: widget.attachments.length,
              itemBuilder: (context, index) {
                return referenMaterials(
                  widget.attachments[index],
                );
              }),
        ),
        const SizedBox(
          height: 10,
        ),

        //////////////////////////////////////////////
      ]),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      ),
    );
  }

  Widget referenMaterials(String attachements) {
    return InkWell(
      onTap: () {
        if (attachements.split("#")[1].split(".")[1].contains("jpg") ||
            attachements.split("#")[1].split(".")[1].contains("jepg") ||
            attachements.split("#")[1].split(".")[1].contains("png")) {
          showNetworkImageDialog(context, attachements);
        } else if (attachements.split("#")[1].split(".")[1].contains("mp4")) {
          //// video
        } else {
          /// pdf
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  Text(attachements.split("#")[1]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showNetworkImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
