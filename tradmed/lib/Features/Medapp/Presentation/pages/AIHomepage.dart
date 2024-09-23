// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';

class Aihomepage extends StatelessWidget {
  const Aihomepage({super.key});

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
                        'Hello,',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                  "Let's meet a powerful AI assistant",
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
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.circular(20), // Curving the container
                ),
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Unlock your Ai chatbot & get',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text('all Premium features',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Upgrade Plan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
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
                  'Features',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    _getFeatures('Health Tip'),
                    SizedBox(
                      width: 15,
                    ),
                    _getFeatures('Articles'),
                    SizedBox(
                      width: 15,
                    ),
                    _getFeatures('Healing Herbs'),
                    SizedBox(
                      width: 15,
                    ),
                    _getFeatures('AloeVera'),
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
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(
                              20), // Curving the container
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/chatMessage.svg'),
                            SizedBox(height: 10),
                            Text(
                              'Chat / Talk',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Talk with AI to get diagnosed',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              'explore medicines, and find',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              'solutions quickly.',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.circular(20), // Curving the container
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/VoiceIcon.svg'),
                          SizedBox(height: 10),
                          Text(
                            'Voice / Speech',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Engage in real time ',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            'conversation with our Ai and',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            'gain new insights.',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _getFeatures(String data) {
  if (data == 'Health Tip') {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
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
