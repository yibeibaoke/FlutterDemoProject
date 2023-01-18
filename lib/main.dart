import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:little_sea_otter/views/home_view.dart';
import 'package:little_sea_otter/views/login_view.dart';
import 'package:little_sea_otter/views/register_view.dart';
import 'package:little_sea_otter/views/stories_view.dart';
import 'package:little_sea_otter/views/verify_email_view.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: homeRoute,
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        storiesRoute: (context) => const StoriesView(),
        homeRoute: (context) => const Home(),
      },
    );
  }
}
