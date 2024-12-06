// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class UTubePlayer extends StatefulWidget {
//   final String videoId;
//   const UTubePlayer({
//     super.key,
//     required this.videoId,
//   });

//   @override
//   State<UTubePlayer> createState() => _UTubePlayerState();
// }

// class _UTubePlayerState extends State<UTubePlayer> {
//   final YoutubePlayerController _controller = YoutubePlayerController(
//     params: const YoutubePlayerParams(showFullscreenButton: true),
//   );

//   @override
//   void initState() {
//     super.initState();
//     _controller.loadVideoById(videoId: widget.videoId);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.close();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       controller: _controller,
//       builder: (context, player) {
//         return Center(child: player);
//       },
//     );
//   }
// }
