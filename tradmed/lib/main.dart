// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/AIHomepage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/ChatAI.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/DetailsPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/EducationPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/constant.dart';
import 'package:tradmed/pages/Authntication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradmed/pages/home.dart';
import 'package:tradmed/pages/splashscreen.dart';

void main() async {
  Gemini.init(apiKey: Gemini_Api_Key);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        // '/telemedicine': (context) => 
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
