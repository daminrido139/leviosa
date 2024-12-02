import 'package:flutter/material.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/widgets/common/adv_network_image.dart';

class NetworkFileViewer extends StatelessWidget {
  final String typeUrl;
  const NetworkFileViewer({
    super.key,
    required this.typeUrl,
  });

  @override
  Widget build(BuildContext context) {
    final url = typeUrl.split('~').first;
    final type = typeUrl.split('~').last;
    if (['jpg', 'jpeg', 'png'].contains(type)) {
      return imageView(url);
    }
    if (['mp4'].contains(type)) {
      return videoView(url);
    }
    if (['pdf'].contains(type)) {
      return pdfView(url);
    }
    return const SizedBox.shrink();
  }

  Widget imageView(String url) {
    // return Container(
    //   width: double.infinity,
    //   // height: 40,
    //   alignment: Alignment.centerRight,
    //   decoration: const BoxDecoration(
    //     color: leviosaColor,
    //   ),
    //   child: IconButton(
    //       onPressed: () {
    //         // attachments.removeAt(index);
    //         // setState(() {});
    //         // in future, implement delete feature in cloudinary
    //       },
    //       icon: const Icon(Icons.close)),
    // );
    return AdvancedNetworkImage(
      imgUrl: url,
      height: 300,
      width: 600,
    );
  }

  Widget videoView(String url) {
    print(url + "🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰");
    print(url.split("/")[-1]);
    return Container(
      width: double.infinity,
      // height: 40,
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(
        color: leviosaColor,
      ),
      child: IconButton(
          onPressed: () {
            // attachments.removeAt(index);
            // setState(() {});
            // in future, implement delete feature in cloudinary
          },
          icon: const Icon(Icons.close)),
    );
    // implement video player using better_player package
  }

  Widget pdfView(String url) {
    String filename = url.split("/").last;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        // height: 40,
        // alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: leviosaColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset("assets/file/pdflogo.png"),
              ),
            ),
            Text(filename),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // attachments.removeAt(index);
                  // setState(() {});
                  // in future, implement delete feature in cloudinary
                },
                icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
    // implement a box, if it clicks, push a new page and display pdf using syncfusion_pdf_viewer package
  }
}
