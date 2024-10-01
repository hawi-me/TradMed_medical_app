// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/LanguageProvider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/widgets/nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentFeatureIndex = 0;
  Timer? _timer;

  // List of app features
  final List<Map<String, dynamic>> _appFeatures = [
    {
      'icon': Icons.search,
      'title': 'AI Herbal Medicine Suggestion',
      'description':
          'Our AI will suggest herbal medicines for your health needs.',
    },
    {
      'icon': Icons.local_hospital,
      'title': 'Health Education',
      'description':
          'Get health education based on your location to help you learn more about herbal treatments.',
    },
    {
      'icon': Icons.medical_services,
      'title': 'Search for Diseases',
      'description':
          'Search diseases and get a list of herbal medicines that have user feedback and proven effectiveness.',
    },
    {
      'icon': Icons.chat,
      'title': 'Talk to Herbal Professionals',
      'description':
          'Consult with herbal professionals and get personalized suggestions.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startFeatureAutoChange();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Auto change features every 3 seconds
  void _startFeatureAutoChange() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentFeatureIndex =
            (_currentFeatureIndex + 1) % _appFeatures.length; // Loop features
      });
    });
  }

  int _selectedIndex = 0; // Default to Home page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/educationpage');
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
    return Scaffold(
      drawer: Nav(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer<Languageprovider>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    // Display flag based on language
                    Text(
                      _getFlag(provider.locale.languageCode),
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 10),

                    // Dropdown for the lannguage
                    DropdownButton<String>(
                      value: provider.locale.languageCode,
                      icon: Icon(Icons.language, color: Colors.white),
                      onChanged: (String? newLanguage) {
                        if (newLanguage != null) {
                          provider.switchLanguage(newLanguage);
                        }
                      },
                      items: <String>['en', 'fr', 'es', 'ar']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            _getLanguageName(value),
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 127, 127),
                    borderRadius:
                        BorderRadius.circular(20), // Curving the container
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              Navigator.pushNamed(context, '/navbar');
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage('assets/UserProfile.jpg'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 37,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.homeSearch,
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.green[700]),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 20),
                                ),
                                style: TextStyle(
                                    color: Colors.green[900], fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    AppLocalizations.of(context)!.homeHero,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Animated card to display app features
                _buildFeatureCard(),
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

  // Build a card for the current feature being displayed
  Widget _buildFeatureCard() {
    final feature = _appFeatures[_currentFeatureIndex];
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Card(
        key: ValueKey<int>(_currentFeatureIndex),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                feature['icon'],
                size: 40,
                color: Colors.green[700],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      feature['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //get the flag based on the language code
  String _getFlag(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'ar':
        return '🇸🇦'; 
      default:
        return '🇬🇧'; 
    }
  }

  // Helper method to get the language name based on the language code
  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'ar':
        return 'العربية'; 
      default:
        return 'English';
    }
  }
}
