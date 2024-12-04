import 'dart:convert';
import 'package:crypto/crypto.dart'; // For generating the signature
import 'package:http/http.dart' as http;

class CloudinaryService {
  static Future<String?> uploadFileDirect(String path) async {
    // Replace these with your Cloudinary account details
    const String cloudName = 'djaxz2c58';
    const String apiKey = '156588393944371';
    const String apiSecret = '2NjErOf3liGqr3Vjrw3E-s0dYTk';
    const String uploadUrl =
        'https://api.cloudinary.com/v1_1/$cloudName/raw/upload';

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
    final file = await http.MultipartFile.fromPath(
      'file',
      path,
      filename: path.split('/').last,
    );
    request.files.add(file);

    // Send the request
    final response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      print(jsonResponse);
      final url = jsonResponse['secure_url'];
      if (url == null) {
        return null;
      }
      return '$url~#${path.split('/').last}';

      // print('Upload successful! Response: $jsonResponse');
    }
    //print('Upload failed with status: ${response.statusCode}');
    return null;
  }
}
