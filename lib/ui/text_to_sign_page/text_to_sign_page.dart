import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/services/ai_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/file/avatar_video_player.dart';

class TextToSignPage extends StatefulWidget {
  const TextToSignPage({super.key});

  @override
  State<TextToSignPage> createState() => _TextToSignPageState();
}

class _TextToSignPageState extends State<TextToSignPage> {
  List<double> speed = [1, 0.75, 0.5];
  int currentSpeed = 0;
  final _controller = TextEditingController();
  Map<String, String> modelsInDb = {};
  String? avatarVideoPath;
  String lastWords = '';
  bool loading = false;
  FocusNode focusNode = FocusNode();
  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    modelsInDb = await AiServices.fetch3DModels();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: height * 0.9,
                    child: InteractiveViewer(
                      child: (avatarVideoPath == null || loading)
                          ? Image.asset(
                              'assets/img/avatar.png',
                              fit: BoxFit.cover,
                            )
                          : AvatarVideoPlayer(
                              filePath: avatarVideoPath!,
                              key: UniqueKey(),
                              speed: speed[currentSpeed],
                            ),
                    ),
                  ),
                ),
              ),
              inputField(),
            ],
          ),
          ///////////////////////////////////////////////
          if (!focusNode.hasFocus)
            Positioned(
              bottom: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LeviosaText(
                    lastWords,
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.w500),
                    forceLanguage: Language.gujarati,
                  ),
                  Text(
                    lastWords,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          /////////////////////////////////////////////
          Positioned(
            bottom: 100,
            right: 40,
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
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget inputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onTap: () => setState(() {}),
        controller: _controller,
        focusNode: focusNode,
        onTapOutside: (event) {
          focusNode.unfocus();
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: "Enter the text",
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 233, 223, 190), width: 3)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black)),
          prefixIcon: const Icon(Icons.text_fields_outlined),
          suffixIcon: IconButton(
            onPressed: () async {
              loading = true;
              lastWords = _controller.text;
              setState(() {});
              _controller.clear();
              FocusScope.of(context).unfocus();
              try {
                final formattedSentence =
                    await AiServices.formatSentence(lastWords);
                print(formattedSentence);
                print('😊'); //showSnackBar(formattedSentence, context);
                avatarVideoPath =
                    await AiServices.generateAvatar(lastWords, modelsInDb);
                tts.speak(lastWords);
              } catch (e) {
                showSnackBar('Error', context);
              }
              loading = false;
              setState(() {});
            },
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
