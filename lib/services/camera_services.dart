import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/common_services.dart';

class CameraServices {
  static Future<String> predictGesture(
      Uint8List image, BuildContext context) async {
    String result = '';
    //////////////////////////////////////////////
    final Uri url = Uri.parse('http://192.168.213.41:10000/upload');
    // final Uri url = Uri.parse(leviosaServer);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/octet-stream',
          'Filename': 'filename', // Custom header for the filename
        },
        body: image, // Directly send the binary data
      );

      if (response.statusCode == 200) {
        result = jsonDecode(response.body)['res'] ?? '';
      } else {
        showSnackBar(
            "Failed to upload image: ${response.statusCode}\n ${jsonDecode(response.body)['error']}",
            context);
      }
    } catch (e) {
      showSnackBar("Error: $e", context);
    }
    return result;
  }
}
