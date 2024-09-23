// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/AIHomepage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/ChatAI.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/DetailsPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/EducationPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/constant.dart';

void main() {
  Gemini.init(apiKey: Gemini_Api_Key);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Aihomepage(),
        '/navbar': (context) => Nav(),
        '/details': (context) => Detailspage(),
        '/chatai': (context) => Chatai(),
        // '/aihomepage': (context) => Aihomepage(),
        '/educationpage': (context) => Educationpage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
