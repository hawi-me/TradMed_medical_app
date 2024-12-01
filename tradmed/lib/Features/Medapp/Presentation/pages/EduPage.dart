// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/EducationPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/MainArticles.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/widgets/nav_bar.dart';

class EducationAndArticlesPage extends StatefulWidget {
  const EducationAndArticlesPage({super.key});

  @override
  State<EducationAndArticlesPage> createState() =>
      _EducationAndArticlesPageState();
}

class _EducationAndArticlesPageState extends State<EducationAndArticlesPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/homepage');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushNamed(context, '/telemedicinepage');
        break;
      case 3:
        Navigator.pushNamed(context, '/aihomepage');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, // Two tabs
      child: Scaffold(
        drawer: Nav(),
        appBar: AppBar(
          title: Text('Education'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Articles'),
              // Tab(text: 'Videos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Mainarticles(),
            Educationpage(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
