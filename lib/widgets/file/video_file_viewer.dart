import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoFileViewer extends StatelessWidget {
  const VideoFileViewer({super.key, this.url, this.filepath});
  final String? url;
  final String? filepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example player"),
      ),
      body: AspectRatio(
          aspectRatio: 16 / 9,
          child: url != null
              ? BetterPlayer.network(
                  url!,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    aspectRatio: 16 / 9,
                  ),
                )
              : BetterPlayer.file(
                  filepath!,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    aspectRatio: 16 / 9,
                  ),
                )),
    );
  }
}
