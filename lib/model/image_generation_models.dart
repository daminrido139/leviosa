import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isSearching = false;
  Uint8List? imageData;

  void loadingChange(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void searchingChange(bool val) {
    isSearching = val;
    notifyListeners();
  }

  Future<void> textToImage(String prompt, BuildContext context) async {
    String engineId = "stable-diffusion-v1-6";
    String apiHost = 'https://api.stability.ai';
    String apiKey = 'sk-Urz8ZXKojoIdZJXaOZmARnpCjQuqXm9GEcMwK7kZwkKRdJoE';
    debugPrint(prompt);
    final response = await http.post(
        Uri.parse('$apiHost/v1/generation/$engineId/text-to-image'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "image/png",
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode({
          "text_prompts": [
            {
              "text": prompt,
              "weight": 1,
            }
          ],
          "cfg_scale": 7,
          "height": 1024,
          "width": 1024,
          "samples": 1,
          "steps": 30,
        }));

    if (response.statusCode == 200) {
      try {
        debugPrint(response.statusCode.toString());
        imageData = response.bodyBytes;
        loadingChange(true);
        searchingChange(false);
        notifyListeners();
      } on Exception {
        debugPrint("failed to generate image");
      }
    } else {
      debugPrint("failed to generate image");
    }
  }
}
