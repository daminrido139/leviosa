// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leviosa/services/cloudinary_service.dart';

class FileServices {
  static final ImagePicker picker = ImagePicker();

  static Future pickPdf(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        String filename = result.files.single.path!.split("/").last;

        return [
          File(result.files.single.path!),
          filename,
          result.files.single.path!
        ];
      }

      return [null, null];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    }

    // return result.files.map((f) => f.path).toList();
  }

  static Future pickImage(BuildContext context) async {
    try {
      // Pick an image from the specified source (camera or gallery)
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Return the file path
        return [
          File(pickedFile.path),
          pickedFile.path.split("/").last,
          pickedFile.path
        ];
      } else {
        // If no image was selected
        return [null, null];
      }
    } catch (e) {
      // Handle errors
      print("Error picking image: $e");
      return null;
    }
  }

  static Future pickVideos({
    Duration? maxDuration,
  }) async {
    final xFile = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: maxDuration);
    if (xFile == null) {
      return [null, null];
    }

    return [File(xFile.path), xFile.path.split("/").last, xFile.path];
  }

////////////////////////////////////// Store cloudinery //////////////////////////////////////////
  static Future storeCloudinery(attachment) async {
    List<String> storedlst = [];
    for (var i in attachment) {
      if (i[0] != null) {
        final encodedLink = await CloudinaryService.uploadFileDirect(i[2]);

        if (encodedLink != null) {
          storedlst.add(encodedLink);
        }
      }
    }
    return storedlst;
  }
}
