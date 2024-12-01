import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
              height: 210,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 198, 153, 3),
                      Color.fromARGB(255, 254, 234, 168)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(150, 100),
                      bottomRight: Radius.elliptical(150, 100))),
            ),
            const SizedBox(
              height: 40,
            ),
            profilelist(
                Icons.person_4_outlined, context.read<UserCubit>().state.name),
            const Divider(),
            profilelist(Icons.email_outlined, "Kabilan@kct.com"),
            const Divider(),
            profilelist(
                Icons.numbers_outlined,
                context.read<UserCubit>().state.rollno == null
                    ? context
                        .read<UserCubit>()
                        .state
                        .role
                        .toString()
                        .split(".")[1]
                    : context.read<UserCubit>().state.rollno!),
            const Divider(),
            profilelist(Icons.group, "Indra Devi"),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.password,
                    color: leviosaColor,
                    size: 30,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  LeviosaText(
                    "Request to Change Password",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  BackButton(),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
            const Divider(),
          ],
        ),
        Positioned(
          top: 26,
          left: 20,
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        Positioned(
            top: 80,
            left: 145,
            child: LeviosaText(
              context.read<UserCubit>().state.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )),
        Positioned(
            top: 110,
            left: 165,
            child: LeviosaText(
              context.read<UserCubit>().state.role.toString().split(".")[1],
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )),
        Positioned(
            top: 140,
            left: 145,
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: const Center(
                    child: Icon(
                  Icons.person,
                  size: 60,
                  grade: 10,
                  color: leviosaColor,
                ))))
      ],
    ));
  }

  Widget profilelist(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          Icon(
            icon,
            color: leviosaColor,
            size: 30,
          ),
          const SizedBox(
            width: 60,
          ),
          LeviosaText(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
