import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leviosa/app_router.dart';
import 'package:leviosa/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp.router(
        routerConfig: appRouter,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(0.9)),
            child: child!,
          );
        },
        theme: ThemeData(
          colorSchemeSeed: Colors.yellow,
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
