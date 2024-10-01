// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/widgets/nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Aihomepage extends StatefulWidget {
  const Aihomepage({super.key});

  @override
  State<Aihomepage> createState() => _AihomepageState();
}

class _AihomepageState extends State<Aihomepage> {
  int _selectedIndex = 3; // Default to Education page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/homepage');
        break;
      case 1:
        Navigator.pushNamed(context, '/educationpage');
        break;
      case 2:
        Navigator.pushNamed(context, '/telemedicinepage');
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Nav(),
      appBar: AppBar(
        title: Text('Gemini'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 1. name and profile pic
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcomeMessage,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        Navigator.pushNamed(context, '/navbar');
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/UserProfile.jpg'),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 15,
                ),

                // 2. lets meet ai text

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context)!.meetAI,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                // Upgrading plan
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 127, 127),
                    borderRadius:
                        BorderRadius.circular(20), // Curving the container
                  ),
                  // color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        //when changed language this ensures the text to wrap if exceeds limit
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.premiumPlan,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.unlockAI,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  textAlign: TextAlign.center,
                                  AppLocalizations.of(context)!.upgradePlan,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/RoboAI.png',
                        width: 130,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),

                //Features
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLocalizations.of(context)!.features,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      _getFeatures(AppLocalizations.of(context)!.features1),
                      SizedBox(
                        width: 15,
                      ),
                      _getFeatures(AppLocalizations.of(context)!.features2),
                      SizedBox(
                        width: 15,
                      ),
                      _getFeatures(AppLocalizations.of(context)!.features3),
                      SizedBox(
                        width: 15,
                      ),
                      _getFeatures(AppLocalizations.of(context)!.features4),
                    ]),
                  ),
                ),

                // Cards
                SizedBox(height: 30),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/chatai');
                        },
                        child: Container(
                          width:
                              170, //must be fixed along with Expanded to be responsive
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 2, 127, 127),
                            borderRadius: BorderRadius.circular(
                                20), // Curving the container
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset('assets/chatMessage.svg'),
                              SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)!.aitalk,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!.aitalkdetail,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/chatai');
                        },
                        
                        child: Container(
                          width:
                              170, //must be fixed along with Expanded to be responsive
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 2, 127, 127),
                            borderRadius: BorderRadius.circular(
                                20), // Curving the container
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset('assets/VoiceIcon.svg'),
                              SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)!.aivoice,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!.aivoicedetail,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

Widget _getFeatures(String data) {
  if (data == 'Health Tip' || data == 'Conseil santé') {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 2, 127, 127),
        borderRadius: BorderRadius.circular(20), // Curving the container
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        data,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(20), // Curving the container
    ),
    padding: EdgeInsets.all(10),
    child: Text(
      data,
      style: TextStyle(color: Colors.black),
    ),
  );
}
