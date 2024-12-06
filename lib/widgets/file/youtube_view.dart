// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:leviosa/router_constants.dart';
// import 'package:leviosa/widgets/common/adv_network_image.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// class YoutubeView extends StatelessWidget {
//   final String url;
//   const YoutubeView({
//     super.key,
//     required this.url,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final String? videoId = YoutubePlayerController.convertUrlToId(url);
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 42,
//           padding: const EdgeInsets.symmetric(horizontal: 9),
//           decoration: BoxDecoration(
//             color: const Color(0xFFEAEAEA),
//             borderRadius: BorderRadius.circular(4),
//             border: const Border(
//                 left: BorderSide(width: 1, color: Color(0xFFF94646))),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset('assets/img/view_note/youtube_logo.png'),
//               const SizedBox(width: 10),
//               const SizedBox(
//                 width: 250,
//                 child: Text(
//                   'YouTube',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Color(0xFF494949),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (videoId != null)
//           InkWell(
//             onTap: () =>
//                 context.push(RouterConstants.utubePlayer, extra: videoId),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 AdvancedNetworkImage(
//                     imgUrl:
//                         'https://img.youtube.com/vi/$videoId/sddefault.jpg'),
//                 Image.asset('assets/file/youtube_logo.png'),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }
