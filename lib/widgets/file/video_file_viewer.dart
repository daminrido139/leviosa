import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoFileViewer extends StatelessWidget {
  const VideoFileViewer(
      {super.key, this.url, this.filepath, this.ratio = 16 / 9});
  final String? url;
  final String? filepath;
  final double? ratio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: url != null
            ? BetterPlayer.network(
                url!,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: ratio,
                ),
              )
            : BetterPlayer.file(
                filepath!,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: ratio,
                ),
              ),
      ),
    );
  }
}
