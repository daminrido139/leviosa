import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/default_dp.dart';

class DrawerstudentPage extends StatefulWidget {
  const DrawerstudentPage({super.key});

  @override
  State<DrawerstudentPage> createState() => _DrawerstudentPageState();
}

class _DrawerstudentPageState extends State<DrawerstudentPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 233, 223, 190),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            const DefaultDp(name: "Sachita", size: 60),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Sachita R",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            customlisttile("Profile", Icons.person_outline),
            customlisttile("Notification", Icons.notifications_outlined),
            customlisttile("Settings", Icons.settings_outlined),
            customlisttile("Terms and Condition", Icons.security),
            customlisttile("Privacy Polics", Icons.privacy_tip_outlined),
          ],
        ),
      ),
    );
  }

  customlisttile(name, IconData icon) {
    return ListTile(
      title: Text(name),
      leading: Icon(icon),
      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
    );
  }
}
