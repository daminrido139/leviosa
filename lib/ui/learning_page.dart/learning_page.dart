// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
            minScale: 0.4,
            constrained: false,
            maxScale: 10.0,
            transformationController: _controller,
            child: Stack(children: [
              // Image.asset("assets/img/iceland.jpeg")
              Image.asset("assets/img/gamemap.png"),
              const Positioned(
                bottom: 405,
                right: 350,
                child: Column(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 90,
                    ),
                    Text(
                      "Level 2",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Positioned(
                bottom: 635,
                left: 240,
                child: Column(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 90,
                    ),
                    Text(
                      "Level 3",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Positioned(
                bottom: 950,
                left: 475,
                child: Column(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 90,
                    ),
                    Text(
                      "Level 4",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 1245,
                left: 685,
                child: InkWell(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 90,
                      ),
                      Text(
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
                    context.push(RouterConstants.subjectPage);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "START",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ]))
      ],
    );
  }
}
