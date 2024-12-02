import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileServices {
  static final ImagePicker picker = ImagePicker();

  static Future<List<String?>> pickPdf({bool allowMultiple = true}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      return [];
    }
    return result.files.map((f) => f.path).toList();
  }

  static Future<List<String>> pickImage({
    bool allowMultiple = true,
    int imageQuality = 40,
  }) async {
    if (!allowMultiple) {
      final xFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: imageQuality);
      if (xFile == null) {
        return [];
      }
      return [xFile.path];
    } else {
      final xFiles = await picker.pickMultiImage(imageQuality: imageQuality);
      List<String> images = [];
      for (var x in xFiles) {
        images.add(x.path);
      }
      return images;
    }
  }

  static Future<String?> pickVideos({
    Duration? maxDuration,
  }) async {
    final xFile = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: maxDuration);

    return xFile?.path;
  }
}
