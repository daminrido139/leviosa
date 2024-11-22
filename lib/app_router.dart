import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/ui/app_entry.dart';
import 'package:leviosa/ui/common_page/common_student_page.dart';
import 'package:leviosa/ui/common_page/common_teacher_page.dart';
import 'package:leviosa/ui/learning_page.dart/subjectstudents_page.dart';
import 'package:leviosa/ui/learning_page.dart/youtubeplayerpagestudent_page.dart';
import 'package:leviosa/ui/sign_in_page/sign_in_page.dart';

final appRouter = GoRouter(
  redirect: (context, state) {
    // If logged in
    if (AuthService.isLoggedIn()) {
      if (state.fullPath == RouterConstants.signInPage) {
        return RouterConstants.appEntry;
      }
      return null;
    }
    //If not logged in
    return null;
  },
  initialLocation: RouterConstants.signInPage,
  routes: [
    GoRoute(
      path: RouterConstants.signInPage,
      name: RouterConstants.signInPage,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: RouterConstants.subjectPage,
      name: RouterConstants.subjectPage,
      builder: (context, state) => const Subjectspage(),
    ),
    GoRoute(
      path: RouterConstants.youtubePlayScreenPage,
      name: RouterConstants.youtubePlayScreenPage,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return YoutubePlayerScreen(
          youtubeurl: args["youtubeurl"],
          tittle: args["title"],
        );
      },
    ),
    GoRoute(
      path: RouterConstants.appEntry,
      name: RouterConstants.appEntry,
      builder: (context, state) => const AppEntry(),
    ),
    GoRoute(
      path: RouterConstants.commonStudentPageRoute,
      name: RouterConstants.commonStudentPageRoute,
      builder: (context, state) => const CommonStudentPage(),
    ),
    GoRoute(
      path: RouterConstants.commonTeacherPageRoute,
      name: RouterConstants.commonTeacherPageRoute,
      builder: (context, state) => const CommonTeacherPage(),
    ),
    // GoRoute(
    //   path: RouterConstants.callPage,
    //   name: RouterConstants.callPage,
    //   builder: (context, state) {
    //     final args = state.extra as Map<String, dynamic>;
    //     return CallPage(
    //       callId: args["callId"],
    //     );
    //   },
    // ),
  ],
);
