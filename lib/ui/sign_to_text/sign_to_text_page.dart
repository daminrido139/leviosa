import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:leviosa/services/camera_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class SignToTextPage extends StatefulWidget {
  const SignToTextPage({super.key});

  @override
  State<SignToTextPage> createState() => _SignToTextPageState();
}

class _SignToTextPageState extends State<SignToTextPage> {
  String label = "";
  CameraController? cameraController;
  List<CameraDescription>? _availableCameras;
  bool switchingCamera = false;
  double screenWidth = 0;
  double screenHeight = 0;
  bool isRecording = false;
  bool flash = true;
  /////////////////////////////////////////
  bool realtimeMode = true;
  bool predicting = false;
  /////////////////////////////////////
  final List<CameraImage> recordFrames = [];
  FlutterTts flutterTts = FlutterTts();
  Timer? realtimeTimer;

  void initCamera() async {
    _availableCameras = await availableCameras();
    setCameraDirection(CameraLensDirection.front);
  }

  void toggleCameraDirection() {
    if (cameraController == null) return;
    setState(() {
      switchingCamera = true;
    });
    if (cameraController!.description.lensDirection ==
        CameraLensDirection.front) {
      setCameraDirection(CameraLensDirection.back);
    } else {
      setCameraDirection(CameraLensDirection.front);
    }
  }

  Future talkToMe(String text) async {
    if (text.isEmpty) {
      return;
    }
    flutterTts.speak(text);
  }

  Future<void> predictRealtime() async {
    if ((!realtimeMode) || predicting) {
      return;
    }
    predicting = true;
    final image = await cameraController?.takePicture();
    if (image != null) {
      label = await CameraServices.predictGesture(
          (await image.readAsBytes()), context);
    }
    setState(() {});
    predicting = false;
  }

  Future<void> toggleFlashlight() async {
    if (cameraController!.description.lensDirection !=
        CameraLensDirection.front) {
      if (cameraController!.value.isInitialized) {
        if (cameraController!.value.flashMode == FlashMode.off) {
          await cameraController!.setFlashMode(FlashMode.torch);
          setState(() {
            flash = true;
          });
        } else {
          await cameraController!.setFlashMode(FlashMode.off);
          setState(() {
            flash = false;
          });
        }
      }
    }
  }

  Future<void> setCameraDirection(CameraLensDirection direction) async {
    final CameraDescription cameraDescription =
        _availableCameras!.firstWhere((i) => i.lensDirection == direction);
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
    );
    await cameraController!.initialize();
    cameraController!.startImageStream(processImage);
    await Future.delayed(Durations.extralong2);
    switchingCamera = false;

    setState(() {});
  }

  void processImage(CameraImage cameraImage) {
    if (isRecording) {
      recordFrames.add(cameraImage);
    }
  }

  @override
  void initState() {
    initCamera();
    super.initState();
    /////////////////////
    flutterTts.setLanguage("en-US");
    flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    flutterTts.setSpeechRate(0.6);
    flutterTts.setPitch(1);
    /////////////////////

    Future.delayed(const Duration(seconds: 3)).then(
      (_) => realtimeTimer = Timer.periodic(
          const Duration(milliseconds: 100), (t) => predictRealtime()),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    realtimeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor:
          isRecording ? Colors.white : const Color.fromARGB(255, 233, 223, 190),
      body: Column(
        children: [
          _cameraPreview(),
          ////////////////////////////////////////

          ///////////////////////////////////////
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => talkToMe(label),
                    child: const Icon(
                      Icons.volume_up_outlined,
                      color: Colors.black,
                    )),
                /////////////////////////////
                translationMode(),
              ],
            ),
          ),

          //////////////////////////////////
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: realtimeMode
                  ? Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: SizedBox(
                        child: Text(
                          label,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget translationMode() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, top: 12),
      height: 34,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xfff5f5f5)),
      child: Row(
        children: [
          //////////// Realtime //////////
          gradientSelectionBtn('Realtime', true),
          /////////////////////////////

          gradientSelectionBtn('Sentence', false),
        ],
      ),
    );
  }

  Widget gradientSelectionBtn(String label, bool realtime) {
    return MaterialButton(
      color: realtimeMode == realtime ? Colors.green.shade600 : Colors.white,
      minWidth: 95,
      height: 50,
      onPressed: () {
        realtimeMode = realtime;
        setState(() {});
      },
      child: LeviosaText(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: realtimeMode != realtime ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Widget _cameraPreview() {
    return (cameraController == null || switchingCamera)
        ? Container(
            height: screenHeight * 0.65,
            alignment: Alignment.center,
            color: Colors.black,
            child: CircularProgressIndicator(
              color: Colors.blue.shade100,
            ),
          )
        : ClipRRect(
            child: Stack(
              children: [
                SizedOverflowBox(
                  size: Size(screenWidth, screenHeight * 0.65),
                  child: Transform.flip(
                    flipX: (cameraController!.description.lensDirection ==
                            CameraLensDirection.front)
                        ? true
                        : false,
                    child: CameraPreview(cameraController!),
                  ),
                ),
                if (!realtimeMode)
                  Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (isRecording) return;
                        recordFrames.clear();
                        setState(() {
                          isRecording = true;
                        });
                        await Future.delayed(const Duration(seconds: 2));
                        try {
                          await Future.delayed(
                              const Duration(milliseconds: 1500));
                          label = "How are you?";
                        } catch (e) {
                          label = "Turn on Internet Connection";
                        }
                        isRecording = false;
                        setState(() {});
                        talkToMe(label);
                      },
                      child: (isRecording)
                          ? const _StopRecordIcon(Duration(seconds: 2))
                          : const _StartRecordIcon(),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 50,
                  child: IconButton(
                    color: Colors.grey.shade100,
                    onPressed: toggleCameraDirection,
                    icon: Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.black26,
                      ),
                      padding: const EdgeInsets.all(13),
                      child: const Icon(
                        Icons.flip_camera_ios,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 50,
                  child: IconButton(
                    color: Colors.grey.shade100,
                    onPressed: toggleFlashlight,
                    icon: Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.black26,
                      ),
                      padding: const EdgeInsets.all(13),
                      child: Icon(
                        flash == false ? Icons.flash_off : Icons.flash_on,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class _StartRecordIcon extends StatelessWidget {
  const _StartRecordIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: const ShapeDecoration(
        shape: CircleBorder(
            side: BorderSide(
          width: 5,
          color: Colors.white,
        )),
        color: Colors.red,
      ),
    );
  }
}

class _StopRecordIcon extends StatefulWidget {
  const _StopRecordIcon(this.duration);
  final Duration duration;

  @override
  State<_StopRecordIcon> createState() => __StopRecordIconState();
}

class __StopRecordIconState extends State<_StopRecordIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          alignment: Alignment.center,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: Colors.white,
          ),
          child: Container(
            height: 20,
            width: 20,
            decoration: ShapeDecoration(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SizedBox.square(
                dimension: 55,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.red,
                  value: _controller.value,
                ),
              );
            }),
      ],
    );
  }
}
