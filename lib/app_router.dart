import 'package:go_router/go_router.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/ui/Generative_ai/leviosa_chat_bot.dart';
import 'package:leviosa/ui/app_entry.dart';
import 'package:leviosa/ui/chat_page/chat_room.dart';
import 'package:leviosa/ui/chat_page/chat_search_page.dart';
import 'package:leviosa/ui/common_page/common_student_page.dart';
import 'package:leviosa/ui/common_page/common_teacher_page.dart';
import 'package:leviosa/ui/course_channel_page/create_course_page.dart';
import 'package:leviosa/ui/learning_page.dart/subjectstudents_page.dart';
import 'package:leviosa/ui/learning_page.dart/youtubeplayerpagestudent_page.dart';
import 'package:leviosa/ui/settings_page/settingsstudent_page.dart';
import 'package:leviosa/ui/sign_in_page/sign_in_page.dart';
import 'package:leviosa/ui/sign_to_text/sign_to_text_page.dart';
import 'package:leviosa/ui/text_to_sign_page/text_to_sign_page.dart';
import 'package:leviosa/ui/video_meeting_page/videocall_page.dart';

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
      path: RouterConstants.chatRoom,
      name: RouterConstants.chatRoom,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return ChatRoom(
          receiverUid: args["receiver_uid"],
          receiverName: args["receiver_name"],
          leading: args["leading"],
        );
      },
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
      path: RouterConstants.videoCallPage,
      name: RouterConstants.videoCallPage,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return VideocallPage(callId: args["callId"]);
      },
    ),
    GoRoute(
      path: RouterConstants.leviosaChatBot,
      name: RouterConstants.leviosaChatBot,
      builder: (context, state) => const LeviosaChatBot(),
    ),
    GoRoute(
      path: RouterConstants.createCourse,
      name: RouterConstants.createCourse,
      builder: (context, state) => const CreateCoursePage(),
    ),
    GoRoute(
      path: RouterConstants.chatSearchPage,
      name: RouterConstants.chatSearchPage,
      builder: (context, state) => const ChatSearchPage(),
    ),
    GoRoute(
      path: RouterConstants.signToText,
      name: RouterConstants.signToText,
      builder: (context, state) => const SignToTextPage(),
    ),
    GoRoute(
      path: RouterConstants.textToSign,
      name: RouterConstants.textToSign,
      builder: (context, state) => const TextToSignPage(),
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
    GoRoute(
      path: RouterConstants.settingsPageStudents,
      name: RouterConstants.settingsPageStudents,
      builder: (context, state) => const SettingsstudentPage(),
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
