import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class Level2Page extends StatefulWidget {
  const Level2Page({
    super.key,
  });

  @override
  State<Level2Page> createState() => _Level2PageState();
}

class _Level2PageState extends State<Level2Page> {
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
  ) {
    return GestureDetector(
      onTap: () => context.push(push),
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
          ],
        ),
      ),
    );
  }
}
