// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/AIHomepage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/ChatAI.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/DetailsPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/EducationPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradmed/pages/home.dart';
import 'package:tradmed/pages/splashscreen.dart';
import 'package:tradmed/pages/user_list_screen.dart';
import 'package:tradmed/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use the correct Firebase options
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/navbar': (context) => Nav(),
        '/details': (context) => Detailspage(),
        '/chatai': (context) => Chatai(),
        '/aihomepage': (context) => Aihomepage(),
        '/educationpage': (context) => Educationpage(),
        '/homepage': (context) => HomePage(),
        '/telemedicinepage': (context) => UserListScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
