import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/language_picker_dialog.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: leviosaColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            DefaultDp(name: context.read<UserCubit>().state.name, size: 40),
            const SizedBox(
              height: 15,
            ),
            Text(
              context.read<UserCubit>().state.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            LeviosaText(
              context.read<UserCubit>().state.role.toString().split(".")[1],
              style: const TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            customlisttile("Profile", Icons.person_outline, () {
              context.push(RouterConstants.profilePage);
            }),
            customlisttile("Notification", Icons.notifications_outlined, () {}),
            customlisttile(
                "Language",
                Icons.language_outlined,
                () => showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: LanguagePickerDialog(),
                        ))),
            customlisttile("Settings", Icons.settings_outlined, () {
              context.push(RouterConstants.settingsPageStudents);
            }),
            customlisttile("Terms and Condition", Icons.security, () {}),
            customlisttile("Privacy Polics", Icons.privacy_tip_outlined, () {}),
          ],
        ),
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
