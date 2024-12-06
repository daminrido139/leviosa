import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class LearningLevelPage extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final int level;

  const LearningLevelPage({
    super.key,
    required this.level,
    required this.audioPlayer,
  });

  @override
  State<LearningLevelPage> createState() => _LearningLevelPageState();
}

class _LearningLevelPageState extends State<LearningLevelPage> {
  int selectedBox = -1;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg/kids_bg.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: LeviosaText(
            'Level ${widget.level}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white.withOpacity(0.4),
          actions: const [
            Text(
              "0  🪙",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "0  🔥",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: leviosaColor,
        //   child: const Icon(
        //     Icons.arrow_right,
        //     size: 40,
        //   ),
        // ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            shrinkWrap: true,
            itemCount: Utility.level1.length,
            itemBuilder: (context, ind) {
              return customverticalcard(
                  Utility.level1[ind][0],
                  Utility.level1[ind][1],
                  Utility.level1[ind][2],
                  context,
                  ind,
                  Utility.level1[ind][3]);
            }),
      ),
    );
  }

  customverticalcard(
    imgurl,
    tittle,
    subtittle,
    BuildContext context,
    int ind,
    LetterType type,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (selectedBox == ind) {
              selectedBox = -1;
            } else {
              selectedBox = ind;
            }
            setState(() {});
          },
          child: Container(
            color: Colors.white.withOpacity(0.9),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      height: 100,
                      width: 100,
                      imgurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeviosaText(
                      tittle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    LeviosaText(
                      subtittle,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        /////////////////////////////////
        if (ind == selectedBox)
          Container(
            color: Colors.white.withOpacity(0.9),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    await widget.audioPlayer.pause();
                    context.push(
                      RouterConstants.youtubePlayScreenPage,
                      extra: {
                        "youtubeurl": Utility.youtubeLevel1[ind],
                        "title": tittle,
                      },
                    ).then((_) => widget.audioPlayer.resume());
                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blue,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Image.asset('assets/file/youtube_logo.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(
                    RouterConstants.lettersPracticePage,
                    extra: type,
                  ),
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: leviosaColor,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
