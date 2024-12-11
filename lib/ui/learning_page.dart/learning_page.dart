// ignore_for_file: must_be_immutable

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/game_model.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/gaming_services.dart';
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
  GameModel? gameModel;
  List<String> levelRoutes = [
    RouterConstants.level1Page,
    RouterConstants.level2Page,
    RouterConstants.level3Page,
  ];

  @override
  void initState() {
    player.play(AssetSource(kidsBgm));
    player.onPlayerComplete.listen((event) {
      player.play(AssetSource(kidsBgm)); // Replay the audio
    });
    transformationController = TransformationController();
    startAnimate();
    fetchCurrentGameStatus();
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

  Future<void> fetchCurrentGameStatus() async {
    gameModel = await GamingServices.getCurrentGameStatus();
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
                ////////////////////////////////
                ////////////////////////////////////////
                levelGate(2, bottom: 400, right: 355),
                ///////////////////////////////////////////////////
                levelGate(3, bottom: 625, left: 240),
                /////////////////////////////////////////////////////////
                levelGate(4, bottom: 970, left: 625),

                //////////////////////////////////////////////////////////
                levelGate(5, bottom: 1395, left: 575),

                //////////////////////////////////////////
                Positioned(
                  bottom: 250,
                  left: 330,
                  child: InkWell(
                    onTap: gameModel == null
                        ? null
                        : () {
                            context.push(
                              RouterConstants.level1Page,
                              extra: {
                                'audio_player': player,
                                'game_model': gameModel!,
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

  Widget levelGate(int level,
      {double? top, double? bottom, double? right, double? left}) {
    bool unlocked = (gameModel != null && gameModel!.level >= level);
    return Positioned(
      bottom: bottom,
      right: right,
      left: left,
      top: top,
      child: InkWell(
        onTap: (unlocked && level <= levelRoutes.length)
            ? () => context.push(levelRoutes[level - 1], extra: {
                  'game_model': gameModel!,
                })
            : null,
        child: unlocked
            ? levelLabel(level.toString())
            : Column(
                children: [
                  SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/img/lock.png")),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Level $level",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              ),
      ),
    );
  }

  Widget levelLabel(String label) {
    return Container(
      height: 100,
      width: 100,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Center(
          child: Text(
        label,
        style: const TextStyle(
            fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }
}
