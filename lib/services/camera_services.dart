// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // import 'package:leviosa/services/common_services.dart';

// class CameraServices {
//   static Future<String> predictGesture(
//       String imgPath, BuildContext context) async {
//     String result = '';
//     //////////////////////////////////////////////
//     // final Uri url = Uri.parse('http://192.168.213.41:5000/upload');
//     final Uri url = Uri.parse('$leviosaServer/upload');
//     final request = http.MultipartRequest('POST', url);

//     request.files.add(await http.MultipartFile.fromPath('file', imgPath));
//     try {
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         result = jsonDecode(response.body)['res'] ?? '';
//       } else {
//         showSnackBar(
//             "Failed to upload image: ${response.statusCode}\n ${jsonDecode(response.body)['error']}",
//             context);
//       }
//     } catch (e) {
//       showSnackBar("Error: $e", context);
//     }
//     return result;
//   }
// }
