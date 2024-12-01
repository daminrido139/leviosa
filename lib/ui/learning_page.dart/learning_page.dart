// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:leviosa/constants.dart';
// import 'package:leviosa/cubit/user_cubit.dart';
// import 'package:leviosa/router_constants.dart';
// import 'package:leviosa/ui/drawer_page/drawer_page.dart';
// import 'package:leviosa/widgets/common/default_dp.dart';
// import 'package:leviosa/widgets/common/leviosa_text.dart';

class Learningpage extends StatefulWidget {
  const Learningpage({super.key});

  @override
  State<Learningpage> createState() => _LearningpageState();
}

class _LearningpageState extends State<Learningpage> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
            minScale: 0.5,
            constrained: false,
            maxScale: 3.0,
            transformationController: _controller,
            child: Stack(children: [
              Image.asset("assets/img/gamemap.png"),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.lock,
                    size: 50,
                  ))
            ]))
      ],
    );
  }
}




//     return Scaffold(
//       key: key,
//       drawer: const DrawerPage(),
//       appBar: AppBar(
//         leadingWidth: 60,
//         backgroundColor: Colors.white,
//         leading: InkWell(
//           onTap: () {
//             key.currentState!.openDrawer();
//           },
//           child: Row(
//             children: [
//               const SizedBox(
//                 width: 15,
//               ),
//               DefaultDp(name: context.read<UserCubit>().state.name, size: 40),
//             ],
//           ),
//         ),
//         title: const LeviosaText(
//           'Learning Section',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1,
//             mainAxisSpacing: 15,
//             crossAxisSpacing: 15),
//         itemCount: Utility.horizontallst.length,
//         itemBuilder: (context, ind) {
//           return customhorizontalcard(Utility.horizontallst[ind], ind, context);
//         },
//       ),
//     );
//   }

//   // SizedBox(
//   customhorizontalcard(imgurl, ind, BuildContext context) {
//     String level = (ind + 1).toString();
//     return InkWell(
//       onTap: () {
//         context.push(RouterConstants.subjectPage);
//       },
//       child: Stack(
//         children: [
//           Container(
//             decoration: ShapeDecoration(
//                 color: const Color.fromARGB(255, 33, 39, 45),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 )),
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Opacity(
//               opacity: 0.4,
//               child: Image.asset(imgurl),
//             ),
//           ),
//           Center(
//             child: LeviosaText(
//               "CLASS $level",
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 28,
//                 color: Color.fromRGBO(245, 245, 245, 1),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
