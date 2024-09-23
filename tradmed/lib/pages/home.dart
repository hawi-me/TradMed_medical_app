import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
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

  // Method to handle bottom navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Green container with search bar
            Container(
              width: double.infinity,
              height: 250,
              color: const Color.fromARGB(255, 2, 127, 127),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.format_list_bulleted_sharp,
                            color: Colors.white),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(width: 20),
                    Text(
                      "Let’s find your herbs that cure all diseases",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for herbal products...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.green[700]),
                          filled: true,
                          fillColor: Colors.green[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                        ),
                        style:
                            TextStyle(color: Colors.green[900], fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Animated card to display app features
            _buildFeatureCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Telemedicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'AI',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 2, 127, 127),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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
          borderRadius: BorderRadius.circular(15),
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
}
