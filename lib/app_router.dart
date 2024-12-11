import 'package:go_router/go_router.dart';
import 'package:leviosa/constants.dart';
import 'package:leviosa/model/course_model.dart';
import 'package:leviosa/router_constants.dart';
import 'package:leviosa/services/auth_service.dart';
import 'package:leviosa/ui/Generative_ai/leviosa_chat_bot.dart';
import 'package:leviosa/ui/app_entry.dart';
import 'package:leviosa/ui/assignment_page/assignment_student_detailed_view.dart';
import 'package:leviosa/ui/assignment_page/new_assignment_page.dart';
import 'package:leviosa/ui/chat_page/chat_room.dart';
import 'package:leviosa/ui/chat_page/chat_search_page.dart';
import 'package:leviosa/ui/common_page/common_parent_page.dart';
import 'package:leviosa/ui/common_page/common_student_page.dart';
import 'package:leviosa/ui/common_page/common_teacher_page.dart';
import 'package:leviosa/ui/course_channel_page/create_course_page.dart';
import 'package:leviosa/ui/course_page/course_student_page.dart';
import 'package:leviosa/ui/course_page/course_teacher_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_1/level_1_page.dart';
import 'package:leviosa/ui/learning_page.dart/learning_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_1/letters_practice_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_2/level_2_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_2/math_table.dart';
import 'package:leviosa/ui/learning_page.dart/level_2/maths_addition_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_2/maths_division_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_2/maths_multiply_page.dart';
import 'package:leviosa/ui/learning_page.dart/level_2/maths_subtraction_page.dart';
import 'package:leviosa/ui/learning_page.dart/youtubeplayerpagestudent_page.dart';
import 'package:leviosa/ui/profile_page/profile_page.dart';
import 'package:leviosa/ui/profile_page/report_view.dart';
import 'package:leviosa/ui/settings_page/settingsstudent_page.dart';
import 'package:leviosa/ui/sign_in_page/sign_in_page.dart';
import 'package:leviosa/ui/sign_to_text/sign_to_text_page.dart';
import 'package:leviosa/ui/text_to_sign_page/text_to_sign_page.dart';
import 'package:leviosa/ui/video_meeting_page/videocall_page.dart';
import 'package:leviosa/widgets/file/pdf_viewer.dart';
import 'package:leviosa/widgets/file/video_file_viewer.dart';

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
      path: RouterConstants.lettersPracticePage,
      name: RouterConstants.lettersPracticePage,
      builder: (context, state) {
        final type = state.extra as LetterType;
        return LettersPracticePage(type: type);
      },
    ),
    GoRoute(
      path: RouterConstants.level1Page,
      name: RouterConstants.level1Page,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return Level1Page(
          audioPlayer: args['audio_player'],
          gameModel: args['game_model'],
        );
      },
    ),
    GoRoute(
      path: RouterConstants.level2Page,
      name: RouterConstants.level2Page,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return Level2Page(
          gameModel: args['game_model'],
        );
      },
    ),
    GoRoute(
      path: RouterConstants.mathsAdditionPage,
      name: RouterConstants.mathsAdditionPage,
      builder: (context, state) => const MathsAdditionPage(),
    ),
    GoRoute(
      path: RouterConstants.mathsSubtractionPage,
      name: RouterConstants.mathsSubtractionPage,
      builder: (context, state) => const MathsSubtractionPage(),
    ),
    GoRoute(
      path: RouterConstants.mathsMultiplyPage,
      name: RouterConstants.mathsMultiplyPage,
      builder: (context, state) => const MathsMultiplyPage(),
    ),
    GoRoute(
      path: RouterConstants.mathsDivisionPage,
      name: RouterConstants.mathsDivisionPage,
      builder: (context, state) => const MathsDivisionPage(),
    ),
    GoRoute(
      path: RouterConstants.mathsTablePage,
      name: RouterConstants.mathsTablePage,
      builder: (context, state) => const MathTable(),
    ),
    GoRoute(
      path: RouterConstants.assignmentStudentDetailedView,
      name: RouterConstants.assignmentStudentDetailedView,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return AssignmentStudentDetailedView(
          desc: args["desc"],
          assignmentname: args["assignmentname"],
          date: args["date"],
          time: args["time"],
          attachments: args["attachments"],
          coursename: args["coursename"],
        );
      },
    ),
    GoRoute(
      path: RouterConstants.profilePage,
      name: RouterConstants.profilePage,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: RouterConstants.learningPage,
      name: RouterConstants.learningPage,
      builder: (context, state) => const Learningpage(),
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
      path: RouterConstants.pdfViewer,
      name: RouterConstants.pdfViewer,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return PdfViewer(
          url: args["url"],
          file: args["file"],
        );
      },
    ),
    GoRoute(
      path: RouterConstants.videoViewer,
      name: RouterConstants.videoViewer,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return VideoFileViewer(
          url: args["url"],
          filepath: args["filepath"],
        );
      },
    ),
    GoRoute(
      path: RouterConstants.commonTeacherPageRoute,
      name: RouterConstants.commonTeacherPageRoute,
      builder: (context, state) {
        return const CommonTeacherPage();
      },
    ),
    GoRoute(
      path: RouterConstants.reportView,
      name: RouterConstants.reportView,
      builder: (context, state) {
        return const ReportView();
      },
    ),
    GoRoute(
      path: RouterConstants.leviosaChatBot,
      name: RouterConstants.leviosaChatBot,
      builder: (context, state) => const LeviosaChatBot(),
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
      path: RouterConstants.commonParentPageRoute,
      name: RouterConstants.commonParentPageRoute,
      builder: (context, state) => const CommonParentPage(),
    ),
    GoRoute(
      path: RouterConstants.courseStudentsPage,
      name: RouterConstants.courseStudentsPage,
      builder: (context, state) {
        final courseModel = state.extra as CourseModel;
        return CourseStudentPage(course: courseModel);
      },
    ),
    GoRoute(
      path: RouterConstants.newAssignmentPage,
      name: RouterConstants.newAssignmentPage,
      builder: (context, state) => const NewAssignmentPage(),
    ),
    GoRoute(
      path: RouterConstants.courseTeachersPage,
      name: RouterConstants.courseTeachersPage,
      builder: (context, state) {
        final courseModel = state.extra as CourseModel;
        return CourseTeacherPage(course: courseModel);
      },
    ),
    // GoRoute(
    //   path: RouterConstants.utubePlayer,
    //   name: RouterConstants.utubePlayer,
    //   builder: (context, state) {
    //     final videoId = state.extra as String;
    //     return UTubePlayer(videoId: videoId);
    //   },
    // ),
    GoRoute(
        path: RouterConstants.createCourse,
        name: RouterConstants.createCourse,
        builder: (context, state) => const CreateCoursePage()),
    GoRoute(
      path: RouterConstants.commonStudentPageRoute,
      name: RouterConstants.commonStudentPageRoute,
      builder: (context, state) => const CommonStudentPage(),
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
