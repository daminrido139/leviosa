import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class ProfileParentPage extends StatelessWidget {
  const ProfileParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: LeviosaText("Profile page for parent"),
    ));
  }
}
