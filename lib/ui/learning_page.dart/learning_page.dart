// ignore_for_file: must_be_immutable

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/router_constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:leviosa/constants.dart';
// import 'package:leviosa/cubit/user_cubit.dart';
// import 'package:leviosa/router_constants.dart';
// import 'package:leviosa/ui/drawer_page/drawer_page.dart';
// import 'package:leviosa/widgets/common/default_dp.dart';
// import 'package:leviosa/widgets/common/leviosa_text.dart';

class Learningpage extends StatefulWidget {
  const Learningpage({super.key});

  @override
  State<Learningpage> createState() => _LearningpageState();
}

class _LearningpageState extends State<Learningpage> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  late final TransformationController transformationController;
  final player = AudioPlayer();
  bool isMoved = false;

  @override
  void initState() {
    player.play(AssetSource(kidsBgm));
    player.onPlayerComplete.listen((event) {
      player.play(AssetSource(kidsBgm)); // Replay the audio
    });
    transformationController = TransformationController();
    startAnimate();
    super.initState();
  }

  void startAnimate() async {
    double x = 0.0;
    double y = 0.0;
    while (x > -200.0) {
      x -= 2.50;
      y -= 10.0;
      await Future.delayed(const Duration(milliseconds: 10));
      setState(() {
        transformationController.value = Matrix4.identity()..translate(x, y);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InteractiveViewer(
              minScale: 0.4,
              constrained: false,
              maxScale: 10.0,
              transformationController: transformationController,
              child: Stack(children: [
                Image.asset("assets/img/gamemap.png"),
                // AnimatedPositioned(
                //     bottom: isMoved == false ? 240 : 400,
                //     // right: isMoved == false ? 355 : null,
                //     right: isMoved == false ? null : 355,
                //     duration: const Duration(seconds: 5),
                //     child: InkWell(
                //       onTap: () {
                //         isMoved = true;
                //         setState(() {});
                //       },
                //       child: Column(
                //         children: [
                //           SizedBox(
                //               height: 70,
                //               width: 70,
                //               child: Image.asset("assets/img/key.png")),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           const Text(
                //             "Level 2",
                //             style: TextStyle(
                //                 fontSize: 22, fontWeight: FontWeight.bold),
                //           )
                //         ],
                //       ),
                //     )),
                Positioned(
                  bottom: isMoved == false ? 240 : 400,
                  // right: isMoved == false ? 355 : null,
                  right: isMoved == false ? null : 350,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: const Center(
                        child: Text(
                      "2",
                      style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                Positioned(
                  bottom: 400,
                  right: 355,
                  child: InkWell(
                    onTap: () => context.push(RouterConstants.level2Page),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.asset("assets/img/lock.png")),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Level 2",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 625,
                  left: 240,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.asset("assets/img/lock.png")),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Level 3",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 970,
                  left: 625,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.asset("assets/img/lock.png")),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Level 4",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 1395,
                  left: 575,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.asset("assets/img/lock.png")),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Level 5",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 250,
                  left: 330,
                  child: InkWell(
                    onTap: () {
                      // setState(() {
                      //   isMoved = true;
                      // });
                      context.push(
                        RouterConstants.level1Page,
                        extra: {
                          'level': 1,
                          'audio_player': player,
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "START",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ])),
          Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 36,
              ))
        ],
      ),
    );
  }
}
