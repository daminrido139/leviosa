import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class LearningLevelPage extends StatefulWidget {
  final int level;

  const LearningLevelPage({super.key, required this.level});

  @override
  State<LearningLevelPage> createState() => _LearningLevelPageState();
}

class _LearningLevelPageState extends State<LearningLevelPage> {
  int selectedBox = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LeviosaText(
          'Level ${widget.level}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: leviosaColor,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: leviosaColor,
        child: const Icon(
          Icons.arrow_right,
          size: 40,
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 5),
          shrinkWrap: true,
          itemCount: Utility.level1.length,
          itemBuilder: (context, ind) {
            return customverticalcard(Utility.level1[ind][0],
                Utility.level1[ind][1], Utility.level1[ind][2], context, ind);
          }),
    );
  }

  customverticalcard(imgurl, tittle, subtittle, BuildContext context, int ind) {
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
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all()),
                        child: Image.asset(imgurl)),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    LeviosaText(
                      tittle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    LeviosaText(
                      subtittle,
                      style: TextStyle(
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
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => context.push(
                    RouterConstants.youtubePlayScreenPage,
                    extra: {
                      "youtubeurl": Utility.youtubeLevel1[ind],
                      "title": tittle,
                    },
                  ),
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
                  onTap: () =>
                      context.push(RouterConstants.lettersPracticePage),
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
