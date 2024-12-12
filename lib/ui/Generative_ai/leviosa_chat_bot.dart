import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/widgets/common/gradient_text.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class LeviosaChatBot extends StatefulWidget {
  const LeviosaChatBot({super.key});

  @override
  State<LeviosaChatBot> createState() => _LeviosaChatBotState();
}

class _LeviosaChatBotState extends State<LeviosaChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List _messages = [];
  bool isloading = false;
  String text = "";
  bool ismsgortxt = false;
  bool isloadingimg = false;

  // Replace this with your actual API key

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _sendMessage() async {
    FocusScope.of(context).unfocus();

    setState(() {
      text = _controller.text;
    });
    _controller.clear();

    if (text != "") {
      setState(() {
        _messages.insert(0, {'text': text, 'sender': 'user', 'image': false});
      });
      setState(() {
        isloading = true;
      });

      String aiResponse = await _fetchGeminiAIResponse(text);

      setState(() {
        _messages
            .insert(0, {'text': aiResponse, 'sender': 'ai', "image": false});
      });
      setState(() {
        isloading = false;
      });
    }
  }

  static final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyAfCKcnsK08BZ_ddwm2KPvuUdvzJ5lqBkA',
  );
  final chat = model.startChat(history: [
    Content.text(
        'You are a Chat bot, your name is Leviosa, a helpful and friendly learning assistant especially for deaf and mute students. Your goal is to provide educational explanations based on the user'
        "s request.")
  ]);

  _fetchGeminiAIResponse(String userInput) async {
    final response = await chat.sendMessage(
      Content.text(userInput),
    );
    return response.text ?? "Try again";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const GradientText(
          "લેવિયોસા ચેટબોટ",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          gradient: LinearGradient(
              colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)]),
        ),
        // title: LeviosaText(
        //   'Leviosa ChatBot',
        //   style:
        //       TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 30,
            height: 30,
            child: Image.asset("assets/img/chatbot_15320513.png"),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/chat-bg.jpeg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        bool isUserMessage =
                            _messages[index]['sender'] == 'user';
                        bool ismsg = _messages[index]['image'];
                        return ismsg == false
                            ? _buildChatBubble(
                                _messages[index]['text']!, isUserMessage)
                            : customimagegen(_messages[index]["u18lst"]);
                      },
                    ),
                    isloading == true
                        ? Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                )),
                            child: Image.asset(
                                "assets/img/Ellipsis@1x-1.0s-200px-200px.gif"))
                        : const SizedBox(),
                    isloadingimg == true
                        ? SizedBox(
                            height: 320,
                            width: 320,
                            child: Image.asset(
                                "assets/img/Spinner@1x-1.0s-200px-200px (1).gif"))
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isUserMessage) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.amber[600] : Colors.black,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: LeviosaText(
          message,
          style: TextStyle(
            color: isUserMessage ? Colors.black : Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 5,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'એક સંદેશ ટાઈપ કરો...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ismsgortxt == false
                      ? IconButton(
                          onPressed: () {
                            ismsgortxt = !ismsgortxt;
                            setState(() {});
                          },
                          icon: const Icon(Icons.image))
                      : IconButton(
                          onPressed: () {
                            ismsgortxt = !ismsgortxt;
                            setState(() {});
                          },
                          icon: const Icon(Icons.text_fields_outlined)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: ismsgortxt == false
                ? () => _sendMessage()
                : () => sentimagge(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: leviosaColor,
                  shape: BoxShape.circle),
              child: const Icon(Icons.send, color: Colors.black),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Future<void> sentimagge(context) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isloadingimg = true;
      text = _controller.text;
    });
    _controller.clear();
    if (text != "") {
      _messages.insert(0, {'text': text, 'sender': 'user', 'image': false});

      final img = await textToImage(text, context);
      if (img != null) {
        _messages.insert(0, {"image": true, "u18lst": img});
      }
      setState(() {
        isloadingimg = false;
      });
    }
  }

  customimagegen(img) {
    return img != null
        ? Container(
            alignment: Alignment.center,
            height: 320,
            width: 320,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(
                  12.0,
                )),
            child: Image.memory(img,
                frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: frame != null
                      ? child
                      : const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator(strokeWidth: 6),
                        ));
            })))
        : Container(
            alignment: Alignment.center,
            height: 320,
            width: 320,
            decoration: BoxDecoration(
                color: const Color(0xff424242),
                borderRadius: BorderRadius.circular(
                  12.0,
                )));
  }

  Future<Uint8List?> textToImage(String prompt, BuildContext context) async {
    String engineId = "stable-diffusion-v1-6";
    String apiHost = 'https://api.stability.ai';
    String apiKey = 'sk-Urz8ZXKojoIdZJXaOZmARnpCjQuqXm9GEcMwK7kZwkKRdJoE';
    debugPrint(prompt);
    final response = await http.post(
        Uri.parse('$apiHost/v1/generation/$engineId/text-to-image'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "image/png",
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode({
          "text_prompts": [
            {
              "text": prompt,
              "weight": 1,
            }
          ],
          "cfg_scale": 7,
          "height": 1024,
          "width": 1024,
          "samples": 1,
          "steps": 30,
        }));

    if (response.statusCode == 200) {
      try {
        debugPrint(response.statusCode.toString());
        return response.bodyBytes;
      } on Exception {
        debugPrint("failed to generate image");
      }
    } else {
      debugPrint("failed to generate image");
    }
    return null;
  }
}
