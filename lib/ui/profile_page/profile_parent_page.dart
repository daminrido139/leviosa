import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/widgets/common/chart.dart';
import 'package:leviosa/widgets/common/default_dp.dart';
import 'package:leviosa/widgets/common/dynamic_cv_preview.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class ProfileParentPage extends StatelessWidget {
  const ProfileParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(child: customcontainer(context)),
            const DynamicCvPreview(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: LearningsChart(),
            ),
            profilelisttitle("Annual Report"),
            profilelisttitle("Monthly Report"),
            profilelisttitle("Weakly Report"),
          ],
        ),
      ),
    );
  }

  Widget profilelisttitle(String name) {
    return ListTile(
      onTap: () {},
      title: LeviosaText(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      dense: true,
    );
  }

  Widget customcontainer(BuildContext context) {
    return Container(
        height: 140,
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(228, 212, 156, 1),
                Color.fromARGB(255, 233, 223, 190)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 253, 249, 227),
            boxShadow: [
              BoxShadow(
                  color:
                      const Color.fromARGB(255, 241, 228, 190).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5)
            ]),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    child: DefaultDp(name: "Sachita", size: 100),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          "Sachita R",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "22BAU020",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          "K.L.Institute For The Deaf",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]));
  }
}
