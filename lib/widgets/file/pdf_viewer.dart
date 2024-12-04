import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.url});
  final File url;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.file(widget.url),
      // body: SfPdfViewer.network(
      //   widget.url,
      //   key: _pdfViewerKey,
      // ),
    );
  }
}
