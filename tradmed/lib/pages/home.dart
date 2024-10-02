// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/LanguageProvider.dart';
import 'package:flutter/services.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/fech/fetching.dart';
import 'package:tradmed/pages/Authntication.dart';
import 'package:tradmed/pages/diseasfetch.dart';
import 'package:tradmed/pages/searchresult.dart';
import 'package:tradmed/widgets/card.dart';
import 'package:tradmed/widgets/nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

// enum SearchType { herb, disease }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentFeatureIndex = 0;
  Timer? _timer;
  TextEditingController _controller =
      TextEditingController(); // Initialize TextEditingController

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
  List herbalMedicines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _startFeatureAutoChange();
    fetchHerbalMedicines();
  }

  Future<void> fetchHerbalMedicines() async {
    try {
      final String response = await rootBundle.loadString('assets/herb.json');
      final data = await json.decode(response);
      setState(() {
        herbalMedicines = data['herbal_medicines'];
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading herbal medicines: $error')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller
    _timer?.cancel();
    super.dispose();
  }

  // Auto change features every 5 seconds
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

  Future<void> _logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User logged out successfully');
      // Navigate to the login page after logout
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AuthPage())); // Adjust the route name accordingly
    } catch (e) {
      print('Logout failed: $e');
      // Handle any errors during the logout process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  String _selectedSearchType = 'herb'; // Default to 'herb'
  void _performSearch() {
    if (_controller.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(
            query: _controller.text,
            is_value: _selectedSearchType,
          ),
        ),
      );
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
                      icon: Icon(Icons.language, color: Colors.grey.shade400),
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                // Search bar and feature section
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 127, 127),
                    borderRadius:
                        BorderRadius.circular(20), // Curving the container
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller, // Text controller
                          decoration: InputDecoration(
                            hintText: _selectedSearchType == 'herb'
                                ? 'Search for herbs...'
                                : 'Search for diseases...',
                            hintStyle: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                            prefixIcon: IconButton(
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchResultsPage(
                                        query: _controller.text,
                                        is_value: _selectedSearchType,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon:
                                  Icon(Icons.search, color: Colors.green[700]),
                            ),
                            filled: true,
                            fillColor: Colors.green[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style:
                              TextStyle(color: Colors.green[900], fontSize: 16),
                          onSubmitted: (value) {
                            _performSearch();
                          },
                        ),
                      ),

                      SizedBox(height: 10), // Add some spacing between elements

                      // Filter Dropdown with custom styling
                      Text(
                        'Search by:',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),

                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSearchType,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.green[700]),
                              iconSize: 30,
                              style: TextStyle(
                                  color: Colors.green[900], fontSize: 16),
                              dropdownColor: Colors.green[50],
                              borderRadius: BorderRadius.circular(15),
                              items: [
                                DropdownMenuItem(
                                  value: 'herb',
                                  child: Row(
                                    children: [
                                      Icon(Icons.eco, color: Colors.green[700]),
                                      SizedBox(width: 10),
                                      Text('Herb'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'disease',
                                  child: Row(
                                    children: [
                                      Icon(Icons.local_hospital,
                                          color: Colors.red[700]),
                                      SizedBox(width: 10),
                                      Text('Disease'),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedSearchType = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Animated card to display app features
                _buildFeatureCard(),
                SizedBox(
                  height: 360,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        herbalMedicines.length < 4 ? herbalMedicines.length : 4,
                    itemBuilder: (context, index) {
                      final medicine = herbalMedicines[index];
                      return HerbHome(
                        image: medicine['image'],
                        name: medicine['name'],
                        description: medicine['description'],
                        price: '${medicine['price']} ${medicine['currency']}',
                        usage: medicine['usage'], // Customize as needed
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 200),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HerbalMedicineListPage(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 1, 101, 126)),
                    ),
                  ),
                ),

                SizedBox(
                  height: 400, // Adjust this height as necessary
                  child: DiseaseListPage(), // Ensure this widget is defined
                ),
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
