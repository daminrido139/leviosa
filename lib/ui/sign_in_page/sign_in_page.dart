// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/services/common_services.dart';
import 'package:leviosa/widgets/common/leviosa_button.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';
import 'package:leviosa/widgets/common/loader.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    isLoading = true;
    setState(() {});
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        return;
      }
      await AuthService.signInWithEmailAndPassword(email, password);
      context.go(RouterConstants.appEntry);
    } catch (e) {
      showSnackBar(e.toString().split(' ').sublist(1).join(' '), context);
    }
    isLoading = false;
    setState(() {});
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
                    child: isLoading
                        ? const Loader()
                        : const LeviosaText(
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
          cursorColor: Colors.black,
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
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
          cursorColor: Colors.black,
          controller: passwordController,
          obscureText: hidePassword,
          decoration: InputDecoration(
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
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
