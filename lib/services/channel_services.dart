import 'package:flutter/services.dart';

class ChannelServices {
  static const MethodChannel channel = MethodChannel('kotlin');

  static Future<String> predictGesture(Uint8List imageBytes) async {
    try {
      final String output = await channel.invokeMethod('predict', imageBytes);
      final prediction = output.split('"');
      if (prediction.length > 1) {
        final result = prediction[1];
        if (result == 'none') {
          return '';
        }
        return result;
      }
    } on PlatformException catch (e) {
      print('Error: $e');
    }
    return '';
  }
}
