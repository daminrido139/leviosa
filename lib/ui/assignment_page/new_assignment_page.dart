import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/services/calendar_services.dart';
import 'package:leviosa/services/cloudinary_service.dart';
import 'package:leviosa/services/course_service.dart';
import 'package:leviosa/services/file_services.dart';
import 'package:leviosa/widgets/common/leviosa_form_field.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/common/loader.dart';
import 'package:leviosa/widgets/file/network_file_viewer.dart';

class NewAssignmentPage extends StatefulWidget {
  const NewAssignmentPage({super.key});

  @override
  State<NewAssignmentPage> createState() => _NewAssignmentPageState();
}

class _NewAssignmentPageState extends State<NewAssignmentPage> {
  bool isAttaching = false;
  List<CourseModel> courses = [];
  String selectedCourse = '';
  List<String> courseNameAndID = [];
  DateTime dueDateTime = DateTime.now().add(const Duration(days: 7));
  TimeOfDay dueTime = TimeOfDay.now();
  List<String> attachments = [];
  bool isLoading = false;

  final TextEditingController assignmentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMyCourses();
  }

  Future<void> fetchMyCourses() async {
    courses = await CourseService.fetchMyTeachingCourses();
    courseNameAndID =
        courses.map((c) => '${c.courseCode} - ${c.courseName}').toList();
    selectedCourse = courseNameAndID[0];
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    assignmentController.dispose();
    descriptionController.dispose();
  }

  Future<void> pickPDFS() async {
    isAttaching = false;
    isLoading = true;
    setState(() {});
    try {
      final pdfs = await FileServices.pickPdf();
      for (var pdf in pdfs) {
        if (pdf != null) {
          final link = await CloudinaryService.uploadFileDirect(pdf);
          if (link != null) {
            attachments.add(link);
          }
        }
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> pickImages() async {
    isAttaching = false;
    isLoading = true;
    setState(() {});
    try {
      final imgs = await FileServices.pickImage();
      for (var img in imgs) {
        final link = await CloudinaryService.uploadFileDirect(img);
        if (link != null) {
          attachments.add(link);
        }
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> pickVideo() async {
    isAttaching = false;
    isLoading = true;
    setState(() {});
    try {
      final video = await FileServices.pickVideos();
      if (video != null) {
        final link = await CloudinaryService.uploadFileDirect(video);
        if (link != null) {
          attachments.add(link);
        }
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LeviosaText('Create Assignment'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
      ),
      body: courses.isEmpty
          ? const Loader()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selectCourse(),
                          ////////////////////////////////
                          const SizedBox(height: 8),
                          //////////////////////////////
                          LeviosaFormField(
                            title: 'Heading',
                            hintText: 'Enter a Heading',
                            controller: assignmentController,
                            titleTextStyle: const TextStyle(fontSize: 18),
                            padding: EdgeInsets.zero,
                          ),
                          /////////////////////////////////
                          const SizedBox(height: 8),
                          //////////////////////////////
                          LeviosaFormField(
                            title: 'Description',
                            hintText: 'Enter a Description',
                            controller: descriptionController,
                            titleTextStyle: const TextStyle(fontSize: 18),
                            padding: EdgeInsets.zero,
                            minLines: 3,
                            maxLines: 7,
                            maxLength: 500,
                          ),
                          /////////////////////////////////////
                          const SizedBox(height: 8),
                          ////////////////////////////////
                          dueDate(),
                          /////////////////////////////////////
                          const SizedBox(height: 15),
                          ////////////////////////////////
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: attachments.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      color: leviosaColor,
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {
                                            attachments.removeAt(index);
                                            setState(() {});
                                            // in future, implement delete feature in cloudinary
                                          },
                                          icon: const Icon(Icons.close)),
                                    ),
                                    NetworkFileViewer(
                                        typeUrl: attachments[index]),
                                  ],
                                );
                              }),
                          const SizedBox(height: 15),
                          //////////////////////////////
                          addAttachment(),
                        ],
                      ),
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////////
                if (isLoading) const LinearProgressIndicator(),
              ],
            ),
    );
  }

  Widget selectCourse() {
    return Row(
      children: [
        const LeviosaText(
          'Select Course: ',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        ///////////////////////////////
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: 2),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFB6B1B1)),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerRight,
            child: DropdownButton(
              padding:
                  const EdgeInsets.only(left: 13, top: 6, bottom: 6, right: 8),
              underline: const SizedBox(),
              dropdownColor: Colors.white,
              value: selectedCourse,
              iconSize: 19,
              borderRadius: BorderRadius.circular(20),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: courseNameAndID.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.45,
                    child: Text(
                      items,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4E4941),
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCourse = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget dueDate() {
    return Row(
      children: [
        const LeviosaText(
          'Due Date: ',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 5),
        ///////////////////////////////
        InkWell(
          onTap: () async {
            final dt = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );
            if (dt == null) {
              return;
            }
            dueDateTime = dt;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 2),
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFB6B1B1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(CalendarServices.dateFromDatetime(dueDateTime)),
          ),
        ),
        const Spacer(),
        const LeviosaText(
          'Due Time: ',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 5),
        ///////////////////////////////
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 0, minute: 0),
            );
            if (time == null) {
              return;
            }
            dueTime = time;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 2),
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFB6B1B1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
                CalendarServices.time12FromDate(dueTime.hour, dueTime.minute)),
          ),
        ),
      ],
    );
  }

  Widget addAttachment() {
    return Column(
      children: [
        Row(
          children: [
            ///////////////////////////////////////////////////////////////////////
            OutlinedButton(
              onPressed: () {
                isAttaching = !isAttaching;
                setState(() {});
              },
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    leviosaColor.withOpacity(isAttaching ? 0.4 : 1),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.attach_file,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  LeviosaText(
                    'Attach',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
            ///////////////////////////////////////////////////////////////////////
            const SizedBox(width: 15),
            if (isAttaching)
              OutlinedButton(
                onPressed: () => pickImages(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: leviosaColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    LeviosaText(
                      'Image',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
          ],
        ),
        /////////////////////////////////////////////////////
        const SizedBox(height: 15),
        if (isAttaching)
          Row(
            children: [
              OutlinedButton(
                onPressed: () => pickVideo(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: leviosaColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.video_collection_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    LeviosaText(
                      'Video',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
              ////////////////////////////////////////////////////
              const SizedBox(width: 15),
              OutlinedButton(
                onPressed: () => pickPDFS(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: leviosaColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.picture_as_pdf_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    LeviosaText(
                      'PDF',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
