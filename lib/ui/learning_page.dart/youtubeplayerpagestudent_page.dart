import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:leviosa/ui/learning_page.dart/writting_pad.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen(
      {super.key, required this.youtubeurl, required this.tittle});
  final String youtubeurl;
  final String tittle;

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  // To control the youtube video functionality
  final _controller = YoutubePlayerController();
  CameraController? cameraController;
  List<CameraDescription>? _availableCameras;
  bool isFullScreen = true;
  int selectedMode = 0;

  void initCamera() async {
    _availableCameras = await availableCameras();
    setCameraDirection(CameraLensDirection.front);
  }

  @override
  void initState() {
    super.initState();
    // TO load a video by its unique id
    _controller.loadVideoById(videoId: widget.youtubeurl);
    initCamera();
  }

  Future<void> setCameraDirection(CameraLensDirection direction) async {
    final CameraDescription cameraDescription =
        _availableCameras!.firstWhere((i) => i.lensDirection == direction);
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
    );
    await cameraController!.initialize();
    setState(() {});
  }

  void switchFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });
  }

  void openCamera() {
    if (isFullScreen) {
      isFullScreen = false;
      setState(() {});
    }
    if (selectedMode == 0) return;
    selectedMode = 0;
    setState(() {});
  }

  void openPad() {
    if (isFullScreen) {
      isFullScreen = false;
      setState(() {});
    }
    if (selectedMode == 1) return;
    selectedMode = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          widget.tittle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: openCamera,
            icon: const Icon(Icons.camera_alt_outlined),
            color: Colors.white,
          ),
          IconButton(
            onPressed: openPad,
            icon: const Icon(Icons.edit),
            color: Colors.white,
          ),
          if (!isFullScreen)
            IconButton(
              onPressed: switchFullScreen,
              icon: const Icon(
                Icons.fullscreen,
              ),
              color: Colors.white,
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        List<Widget> pages = [
          ClipRRect(
            child: SizedOverflowBox(
                size: Size(width, height * 0.5),
                child: (cameraController == null)
                    ? const SizedBox.shrink()
                    : Transform.flip(
                        flipX: true, child: CameraPreview(cameraController!))),
          ),
          Expanded(child: WritingPad(height: (height * 0.5))),
        ];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * (!isFullScreen ? 0.5 : 1),
              child: YoutubePlayer(
                backgroundColor: Colors.black,
                controller: _controller, // Controler that we created earlier
                aspectRatio: width /
                    (height * 0.5), // Aspect ratio you want to take in screen
              ),
            ),
            if (!isFullScreen) pages[selectedMode]
          ],
        );
      }),
    );
  }
}
