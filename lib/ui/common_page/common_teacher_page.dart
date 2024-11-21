import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';

class CommonTeacherPage extends StatefulWidget {
  const CommonTeacherPage({super.key});

  @override
  State<CommonTeacherPage> createState() => _CommonTeacherPageState();
}

class _CommonTeacherPageState extends State<CommonTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Teachers page'),
            const SizedBox(height: 15),
            IconButton(
                onPressed: () async {
                  await AuthService.logout();
                  context.go(RouterConstants.signInPage);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
