import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/model/user_model.dart';
import 'package:leviosa/services/announcement_service.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/announcement/announcement_tile.dart';

class AnnouncementTeacherPage extends StatefulWidget {
  final CourseModel course;
  const AnnouncementTeacherPage({
    super.key,
    required this.course,
  });

  @override
  State<AnnouncementTeacherPage> createState() =>
      _AnnouncementTeacherPageState();
}

class _AnnouncementTeacherPageState extends State<AnnouncementTeacherPage> {
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

  void onSendBtnClicked() {
    AnnouncementService.sendAnnouncement(
      widget.course.id!,
      AuthService.getUserId(),
      _announcementController.text.trim(),
    );
    _announcementController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: buildAnnouncements()),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(width: 8),
            Expanded(child: _textField()),
            const SizedBox(width: 8),
            sendBtn(),
            const SizedBox(width: 8),
          ],
        ),
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

  Widget _textField() {
    return TextField(
      cursorHeight: 20,
      cursorColor: const Color.fromRGBO(12, 12, 12, 1),
      style: const TextStyle(
        color: Color.fromRGBO(12, 12, 12, 1),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.1,
      ),
      controller: _announcementController,
      maxLines: 10,
      minLines: 1,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        hintText: 'Start Typing...',
        hintStyle: const TextStyle(
            color: Color.fromRGBO(151, 151, 151, 1),
            fontSize: 18,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(135, 111, 34, 1)),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(135, 111, 34, 1)),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(135, 111, 34, 1)),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget sendBtn() {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: leviosaColor,
      ),
      child: IconButton(
          onPressed: onSendBtnClicked,
          icon: const Icon(Icons.send,
              size: 28, color: Color.fromRGBO(135, 111, 34, 1))),
    );
  }
}
