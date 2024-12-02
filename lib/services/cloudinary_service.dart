import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart'; // For generating the signature
import 'package:http/http.dart' as http;

Future<String?> uploadFileDirect(Uint8List bytes) async {
  // Replace these with your Cloudinary account details
  const String cloudName = 'djaxz2c58';
  const String apiKey = '156588393944371';
  const String apiSecret = '2NjErOf3liGqr3Vjrw3E-s0dYTk';
  const String uploadUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/auto/upload';

  // Generate a timestamp for the request
  final int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  // Generate the signature
  final String signatureString = 'timestamp=$timestamp$apiSecret';
  final String signature =
      sha1.convert(utf8.encode(signatureString)).toString();

  // Create the multipart request
  final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

  // Add authentication fields
  request.fields['api_key'] = apiKey;
  request.fields['timestamp'] = timestamp.toString();
  request.fields['signature'] = signature;

  // Add the file
  final file = http.MultipartFile.fromBytes('file', bytes);
  request.files.add(file);

  // Send the request
  final response = await request.send();

  // Handle the response
  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    final jsonResponse = json.decode(responseBody);
    return jsonResponse['secure_url'];

    // print('Upload successful! Response: $jsonResponse');
  }
  //print('Upload failed with status: ${response.statusCode}');
  return null;
}
