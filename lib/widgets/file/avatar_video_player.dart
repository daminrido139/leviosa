import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AvatarVideoPlayer extends StatefulWidget {
  final String filePath;
  final double? speed;
  final bool? loop;
  const AvatarVideoPlayer(
      {super.key, required this.filePath, this.speed, this.loop = false});

  @override
  State<AvatarVideoPlayer> createState() => _AvatarVideoPlayerState();
}

class _AvatarVideoPlayerState extends State<AvatarVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
      File(widget.filePath),
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
        if (widget.speed != null) {
          _controller.setPlaybackSpeed(widget.speed!);
        }
        _controller.setLooping(widget.loop!);
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
                height: _controller.value.size.height,
                width: _controller.value.size.width,
                child: VideoPlayer(_controller)),
          )
        : Image.asset(
            'assets/img/avatar.png',
            fit: BoxFit.cover,
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
