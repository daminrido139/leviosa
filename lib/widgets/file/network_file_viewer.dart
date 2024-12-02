import 'package:flutter/material.dart';
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
    return AdvancedNetworkImage(
      imgUrl: url,
      height: 200,
      width: 600,
    );
  }

  Widget videoView(String url) {
    return const SizedBox.shrink();
    // implement video player using better_player package
  }

  Widget pdfView(String url) {
    return const SizedBox.shrink();
    // implement a box, if it clicks, push a new page and display pdf using syncfusion_pdf_viewer package
  }
}
