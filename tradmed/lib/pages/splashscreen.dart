import 'dart:async'; // To add a delay before navigating to the home screen
import 'package:flutter/material.dart';
import 'package:tradmed/pages/Authntication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate loading for 3 seconds before navigating to home page
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (contex) => AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Green background with opacity
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 19, 100, 117)
                .withOpacity(0.6), 
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assests/images/log_1.png', // Your logo or icon
                  height: 120,
                  width: 120,
                ),
                

                // App tagline
                const Text(
                  'Discover Natural Healing',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Loading indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
