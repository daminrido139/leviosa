import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/dynamic_cv_preview.dart';
import 'package:leviosa/widgets/common/gradient_text.dart';
import 'package:leviosa/widgets/common/leviosa_button.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:screenshot/screenshot.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> captureAndSaveScreenshot() async {
    try {
      // // Capture screenshot as image bytes
      // final imageBytes = await screenshotController.capture();

      // if (imageBytes != null) {
      //   // Get the application's temporary directory
      //   final directory = await getApplicationDocumentsDirectory();
      //   final imagePath = '${directory.path}/screenshot.png';

      //   // Save the image file locally
      //   final imageFile = File(imagePath);
      //   await imageFile.writeAsBytes(imageBytes);

      //   // Save image to gallery (optional)
      //   await ImageGallerySaver.saveFile(imageFile.path);

      //   // Show success message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Screenshot saved at $imagePath')),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Failed to capture screenshot')),
      //   );
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                DefaultDp(name: "Damin", size: 40),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      "DAMIN RISHO JV",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.81),
                          Color.fromRGBO(158, 129, 71, 0.81),
                          Color.fromRGBO(247, 171, 22, 0.81),
                        ],
                        stops: [0, 0.3, 1],
                      ),
                    ),
                    LeviosaText("Vinola"),
                  ],
                )
              ],
            ),
            const DynamicCvPreview(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                streakbox(context, "🔥", "0"),
                const Spacer(),
                streakbox(context, "🪙", "0")
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(2.5, 2.5),
                    colors: [Colors.white, Color.fromRGBO(153, 153, 153, 1)],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Course ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "    Date  ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "coins",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, ind) {
                            return listofcompletedcourse((ind + 1).toString(),
                                "coursename", (ind + 5).toString());
                          }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  height: 45,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(2.5, 2.5),
                      colors: [Colors.white, Color.fromRGBO(153, 153, 153, 1)],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: const Center(
                      child: Text(
                    "Share",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                ),
                LeviosaButton(
                    onTap: () {
                      // captureAndSaveScreenshot();
                    },
                    height: 45,
                    child: const Text(
                      "Download",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget listofcompletedcourse(String sno, String coursename, String coins) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            coursename,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          const Text(
            "12 Dec 2024",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            coins,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }

  Widget streakbox(BuildContext context, String imgurl, String count) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width / 2.6,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 10,
      ),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(2.5, 2.5),
          colors: [Colors.white, Color.fromRGBO(153, 153, 153, 1)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            count,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            imgurl,
            style: const TextStyle(fontSize: 50),
          )
        ],
      ),
    );
  }
}
