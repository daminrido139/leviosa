import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key, this.url, this.file});
  final String? url;
  final File? file;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.url == null
          ? SfPdfViewer.file(widget.file!)
          : SfPdfViewer.network(
              widget.url!,
            ),
      // body:
    );
  }
}
