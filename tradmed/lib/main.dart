// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/AIHomepage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/ChatAI.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/DetailsPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/EducationPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/LanguageProvider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/constant.dart';
import 'package:tradmed/l10n/l10n.dart';
import 'package:tradmed/pages/Authntication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tradmed/pages/home.dart';
import 'package:tradmed/pages/splashscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; //must be imported manually!!

void main() async {
  Gemini.init(apiKey: Gemini_Api_Key);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => Languageprovider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Languageprovider>(
      builder: (context, Languageprovider, child) {
        return MaterialApp(
          supportedLocales: L10n.all,
          locale: Languageprovider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate, // Generated localization class
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
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
      },
    );
  }
}
