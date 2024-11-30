// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class SettingsstudentPage extends StatelessWidget {
  const SettingsstudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
        title: const LeviosaText(
          'Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          customlisttile("Appearance", Icons.color_lens, () {}),
          customlisttile("Help & feedback", Icons.help, () {}),
          customlisttile("About", Icons.person_3_outlined, () {}),
          customlisttile("Sign out", Icons.logout, () async {
            await AuthService.logout();
            context.go(RouterConstants.signInPage);
          })
        ],
      ),
    );
  }

  customlisttile(name, IconData icon, ontap) {
    return ListTile(
      onTap: ontap,
      title: LeviosaText(name),
      leading: Icon(icon),
      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
    );
  }
}
