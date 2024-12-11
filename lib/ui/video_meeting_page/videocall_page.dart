/////////////////////////////// first /////////////////////////////////
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:math' as math;

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideocallPage extends StatefulWidget {
  const VideocallPage({super.key, required this.callId});
  static final String userId = math.Random().nextInt(10000).toString();

  final String callId;

  @override
  State<VideocallPage> createState() => _VideocallPageState();
}

class _VideocallPageState extends State<VideocallPage> {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';
  Timer? speechTimer;

  @override
  void initState() {
    super.initState();
    speechTimer = Timer.periodic(
        const Duration(milliseconds: 200), (_) => listenToSpeech());
    _initSpeech();
  }

  void listenToSpeech() {
    if ((!speechEnabled) || speechToText.isListening) {
      return;
    }
    print("🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰🥰");
    print(lastWords);
    startListening();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    await speechToText.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  // void stopListening() async {
  //   await speechToText.stop();
  //   setState(() {});
  // }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechTimer?.cancel();
    speechToText.cancel(); // return Scaffold(
    //   body: Center(
    //     child: Text(lastWords),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: ZegoUIKitPrebuiltCall(
                appID: 1808006113,
                appSign:
                    "d13777c5023210bbe66bdb9688bcbe08eda8f6971c5522de36a6cc046ffb952d",
                callID: widget.callId,
                userID: VideocallPage.userId,
                userName: "userName${VideocallPage.userId}",
                config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()),
          ),
          Container(
            color: const Color.fromARGB(255, 233, 230, 230),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(lastWords),
            ),
          ),
        ],
      ),
    );
  }
}
