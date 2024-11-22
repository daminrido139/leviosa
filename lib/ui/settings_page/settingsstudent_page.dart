import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';

class SettingsstudentPage extends StatelessWidget {
  const SettingsstudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
        title: const Text(
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
      title: Text(name),
      leading: Icon(icon),
      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
    );
  }
}
