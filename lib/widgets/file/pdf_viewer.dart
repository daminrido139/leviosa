import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, required this.url, required this.isnetwork});
  final url;
  final bool isnetwork;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isnetwork == false
          ? SfPdfViewer.file(widget.url)
          : SfPdfViewer.network(
              widget.url,
            ),
      // body:
    );
  }
}
