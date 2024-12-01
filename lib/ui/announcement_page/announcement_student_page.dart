import 'package:flutter/material.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/model/user_model.dart';
import 'package:leviosa/services/announcement_service.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/announcement/announcement_tile.dart';

class AnnouncementStudentPage extends StatefulWidget {
  final CourseModel course;
  const AnnouncementStudentPage({
    super.key,
    required this.course,
  });

  @override
  State<AnnouncementStudentPage> createState() =>
      _AnnouncementStudentPageState();
}

class _AnnouncementStudentPageState extends State<AnnouncementStudentPage> {
  final _announcementController = TextEditingController();
  final Map<String, UserModel?> teachersInfo = {};

  @override
  void dispose() {
    _announcementController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getTeachersInfo();
    super.initState();
  }

  void getTeachersInfo() async {
    teachersInfo
        .addAll((await AnnouncementService.getTeachersInfo(widget.course.id!)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: buildAnnouncements()),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildAnnouncements() {
    return StreamBuilder(
        stream: AnnouncementService.listenAnnouncement(widget.course.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index].data();
                return AnnouncementTile(
                  dpUrl: teachersInfo[doc["sender_id"]]?.profilePicture,
                  name: teachersInfo[doc["sender_id"]]?.name ?? "",
                  message: doc["message"],
                  timestamp: timestampTohhmmm(doc["created_at"]),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
