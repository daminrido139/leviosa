import 'package:flutter/material.dart';
import 'package:leviosa/services/ai_services.dart';
import 'package:leviosa/services/avatar_ai_services.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/file/avatar_video_player.dart';

class AvatarAi extends StatefulWidget {
  const AvatarAi({super.key});

  @override
  State<AvatarAi> createState() => _AvatarAiState();
}

class _AvatarAiState extends State<AvatarAi> {
  final _controller = TextEditingController();
  String? avatarVideoPath;
  Map<String, String> modelsInDb = {};
  FocusNode focusNode = FocusNode();
  String lastWords = '';
  String lastResponse = '';
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
              const SizedBox(height: 70),
              const Text("Avatar AI",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
              Text(lastResponse,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
              inputField(),
            ],
          ),
          ///////////////////////////////////////////////
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
          hintText: "તમારા પ્રશ્નો પૂછો?",
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
                lastResponse = await AvatarAiServices.query(lastWords);
                avatarVideoPath =
                    await AiServices.generateAvatar(lastResponse, modelsInDb);
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
