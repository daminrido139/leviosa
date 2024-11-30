// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/user_service.dart';
import 'package:leviosa/widgets/common/loader.dart';

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final userModel = await UserService.getUserData();
    if (userModel == null) {
      return; // happens if failed to fetch user data
    }
    context.read<UserCubit>().setUser(userModel);
    if (userModel.role == UserRole.student) {
      context.go(RouterConstants.commonStudentPageRoute);
    } else if (userModel.role == UserRole.teacher) {
      context.go(RouterConstants.commonTeacherPageRoute);
    } else {
      context.push(
        RouterConstants.videoCallPage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: const Loader(),
    );
  }
}
