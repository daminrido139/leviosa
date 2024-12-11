import 'package:flutter/material.dart';
import 'package:leviosa/services/ai_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/file/avatar_video_player.dart';

class TextToSignPage extends StatefulWidget {
  const TextToSignPage({super.key});

  @override
  State<TextToSignPage> createState() => _TextToSignPageState();
}

class _TextToSignPageState extends State<TextToSignPage> {
  final _controller = TextEditingController();
  Map<String, String> modelsInDb = {};
  String? avatarVideoPath;
  String lastWords = '';
  bool loading = false;

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
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
                            ),
                    ),
                  ),
                ),
              ),
              inputField(),
            ],
          ),
        ],
      ),
    );
  }

  Widget inputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
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
                setState(() {});
                //showSnackBar(formattedSentence, context);
                avatarVideoPath = await AiServices.generateAvatar(
                    formattedSentence, modelsInDb);
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
