import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadAssignmentFiles(String path) async {
    try {
      final fileName = path.split("/").last;
      final uploadTask =
          await _storage.ref('assignments').child(fileName).putFile(File(path));
      final url = await uploadTask.ref.getDownloadURL();
      return '$url~#$fileName';
    } catch (e) {
      return null;
    }
  }
}
