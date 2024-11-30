import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/app_router.dart';
import 'package:leviosa/cubit/theme_cubit.dart';
import 'package:leviosa/cubit/user_cubit.dart';
import 'package:leviosa/firebase_options.dart';
import 'package:leviosa/l10n/l10n.dart';
import 'package:leviosa/stream/general_stream.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    GeneralStream.languageStream.add(const Locale("en"));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    GeneralStream.languageStream.close;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: StreamBuilder<Locale>(
          stream: GeneralStream.languageStream.stream,
          builder: (context, snapshot) {
            return MaterialApp.router(
              routerConfig: appRouter,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(0.9)),
                  child: child!,
                );
              },
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                brightness: Brightness.light,
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              locale: snapshot.data,
              supportedLocales: L10n.locals,
              localizationsDelegates: const [
                AppLocalizations.delegate,
              ],
            );
          }),
    );
  }
}
