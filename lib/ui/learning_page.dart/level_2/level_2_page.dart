import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/game_model.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class Level2Page extends StatefulWidget {
  final GameModel gameModel;
  const Level2Page({
    super.key,
    required this.gameModel,
  });

  @override
  State<Level2Page> createState() => _Level2PageState();
}

class _Level2PageState extends State<Level2Page> {
  static const int currentLevel = 2;
  int currentLesson = 1;

  @override
  void initState() {
    currentLesson = widget.gameModel.lesson;
    super.initState();
  }

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
          scrolledUnderElevation: 0,
          title: const LeviosaText(
            'Level 2',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            shrinkWrap: true,
            itemCount: Utility.level2.length,
            itemBuilder: (context, ind) {
              return customverticalcard(
                Utility.level2[ind][0],
                Utility.level2[ind][1],
                Utility.level2[ind][2],
                Utility.level2[ind][3],
                ind,
              );
            }),
      ),
    );
  }

  Widget customverticalcard(
    String imgurl,
    String tittle,
    String subtittle,
    String push,
    int ind,
  ) {
    return GestureDetector(
      onTap: (currentLevel > widget.gameModel.level && ind + 1 > currentLesson)
          ? () => showSnackBar(
              'Lesson locked! Complete the previous lesson', context)
          : () => context.push(push),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        color: Colors.white.withOpacity(0.75),
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
            const Spacer(),
            if (currentLevel > widget.gameModel.level &&
                ind + 1 > currentLesson)
              const Icon(
                Icons.lock_outlined,
                size: 34,
              ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ),
    );
  }
}
