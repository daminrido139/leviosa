// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leviosa/services/cloud_service.dart';

class FileServices {
  static final ImagePicker picker = ImagePicker();

  static Future<String?> pickPdf(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        return result.files.single.path;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }
    return null;
  }

  static Future<String?> pickImage(BuildContext context) async {
    try {
      // Pick an image from the specified source (camera or gallery)
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Return the file path
        return pickedFile.path;
      }
    } catch (e) {
      // Handle errors
      print("Error picking image: $e");
    }
    return null;
  }

  static Future<String?> pickVideos({
    Duration? maxDuration,
  }) async {
    final xFile = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: maxDuration);
    if (xFile == null) {
      return null;
    }

    return xFile.path;
  }

////////////////////////////////////// Store cloudinery //////////////////////////////////////////
  static Future<List<String>> storeAttachments(attachment) async {
    List<String> storedlst = [];
    for (String path in attachment) {
      final encodedLink = await CloudService.uploadAssignmentFiles(path);

      if (encodedLink != null) {
        storedlst.add(encodedLink);
      }
    }
    return storedlst;
  }
}
