import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/ai_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

import 'package:leviosa/widgets/file/avatar_video_player.dart';

class T2signBox extends StatefulWidget {
  final Map<String, String>? modelsInDb;
  final String sentence;
  final double width;
  final double height;
  final bool? showClose;
  final bool? showLocalLanguage;
  final bool? directTranslate;
  final bool? loop;
  const T2signBox(
      {super.key,
      this.modelsInDb,
      required this.sentence,
      required this.width,
      required this.height,
      this.showClose = false,
      this.showLocalLanguage = false,
      this.directTranslate = false,
      this.loop});

  @override
  State<T2signBox> createState() => _T2signBoxState();
}

class _T2signBoxState extends State<T2signBox> {
  Map<String, String> modelsInDb = {};
  String? avatarVideoPath;
  List<double> speed = [1, 0.75, 0.5];
  int currentSpeed = 1;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    modelsInDb = widget.modelsInDb ?? (await AiServices.fetch3DModels());
    if (widget.directTranslate!) {
      avatarVideoPath =
          await AiServices.generateAvatar(widget.sentence, modelsInDb);
    } else {
      final formattedSentence =
          await AiServices.formatSentence(widget.sentence);
      avatarVideoPath =
          await AiServices.generateAvatar(formattedSentence, modelsInDb);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final normalSentence =
        '${widget.sentence[0].toUpperCase()}${widget.sentence.substring(1)}'
            .replaceAll('_', ' ');
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: InteractiveViewer(
            child: (avatarVideoPath == null)
                ? Image.asset(
                    'assets/img/avatar.png',
                    fit: BoxFit.cover,
                  )
                : AvatarVideoPlayer(
                    filePath: avatarVideoPath!,
                    key: UniqueKey(),
                    speed: speed[currentSpeed],
                    loop: widget.loop,
                  ),
          ),
        ),
        ///////////////////////
        (widget.showLocalLanguage!)
            ? Positioned(
                bottom: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LeviosaText(
                      normalSentence,
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.w500),
                      forceLanguage: Language.gujarati,
                    ),
                    Text(
                      normalSentence,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              )
            : Positioned(
                bottom: 50,
                child: Text(
                  widget.sentence,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.w500),
                ),
              ),
        /////////////////////////////////
        Positioned(
          bottom: 150,
          right: 10,
          child: FloatingActionButton(
            backgroundColor: leviosaColor,
            onPressed: () {
              if (currentSpeed + 1 == speed.length) {
                currentSpeed = 0;
              } else {
                currentSpeed += 1;
              }
              setState(() {});
            },
            child: Text(
              speed[currentSpeed].toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        if (widget.showClose!)
          Positioned(
            right: 25,
            top: 25,
            child: IconButton(
                iconSize: 40,
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close)),
          ),
      ],
    );
  }
}
