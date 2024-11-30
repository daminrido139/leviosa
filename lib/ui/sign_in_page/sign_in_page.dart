import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/widgets/common/leviosa_button.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        return;
      }
      await AuthService.signInWithEmailAndPassword(email, password);
      context.go(RouterConstants.appEntry);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: LeviosaText(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const SizedBox(height: double.infinity),
          Image.asset(
            "assets/img/sign-in-img.webp",
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            bottom: -MediaQuery.of(context).size.height * 0.48,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      DropdownButton<String>(
                        icon: const Icon(Icons.language_outlined),
                        value:
                            "English", // Ensure this matches one of the items
                        onChanged: (String? newValue) {
                          // Handle selection change
                          print('Selected: $newValue');
                        },
                        items: const [
                          DropdownMenuItem(
                            value: "English",
                            child: LeviosaText("English"),
                          ),
                          DropdownMenuItem(
                            value: "Gujarathi",
                            child: LeviosaText("ગુજરાતી"),
                          ),
                          DropdownMenuItem(
                            value: "Hindi",
                            child: LeviosaText("हिन्दी"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: LeviosaText(
                      "Welcome back 👋",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  emailTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  passwordTextField(),
                  const SizedBox(
                    height: 40,
                  ),
                  LeviosaButton(
                    onTap: _onLogin,
                    width: 200,
                    child: const LeviosaText(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2, color: Color(0xffad9c00)),
            ),
          ),
        ));
  }

  Widget passwordTextField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: passwordController,
          obscureText: hidePassword,
          decoration: InputDecoration(
            labelText: "Password",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2, color: Color(0xffad9c00)),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
          ),
        ));
  }
}
