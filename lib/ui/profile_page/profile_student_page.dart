import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';

class ProfileStudentPage extends StatelessWidget {
  const ProfileStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.logout();
                context.go(RouterConstants.signInPage);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
