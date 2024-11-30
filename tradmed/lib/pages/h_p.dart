import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/LanguageProvider.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/fech/fetching.dart';
import 'package:tradmed/widgets/card.dart';
import 'package:tradmed/widgets/herosection.dart';
import 'package:tradmed/widgets/lateestRemdies.dart';
import 'package:tradmed/widgets/nav_bar.dart';
import 'package:tradmed/widgets/quickacces.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TradMed App',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: HomePage(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  // final String username;

  // const HomePage({Key? key, required this.username}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Selected index for the bottom navigation bar
  int _selectedIndex = 0;
  bool isLoading = true;

  List herbalMedicines = [];
  void initState() {
    super.initState();
    fetchHerbalMedicines();
  }

//  fetching herbs
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
    // Sample data for carousel and recommendations

    final List<String> carouselImages = [
      'assets/log_1.jpg',
      'assets/log_1.jpg',
      'assets/log_1.jpg',
    ];

    final List<Map<String, String>> quickAccess = [
      {'icon': 'assets/undraw_Chat_bot_re_e2gj (1).png', 'label': 'Ask AI'},
      {'icon': 'assets/search.png', 'label': 'Find Remedies'},
      {'icon': 'assets/education.png', 'label': 'Education'},
      {'icon': 'assets/undraw_Blogging_re_kl0d.png', 'label': 'Blog'},
    ];

    final List<Map<String, String>> featuredContent = [
      {'image': 'assets/organic.jpeg', 'title': 'Herbal Medicine Benefits'},
      {'image': 'assets/telemed.png', 'title': 'Natural First Aid Tips'},
      {'image': 'assets/nutri.jpeg', 'title': 'Nutrition with Herbs'},
    ];

    final List<Map<String, String>> Blogs = [
      {
        'image': 'assets/herbal_benfits.jpeg',
        'title': 'Herbal Medicine Benefits'
      },
      {'image': 'assets/herbal_doc.jpeg', 'title': 'Natural First Aid Tips'},
      {'image': 'assets/nutri.jpeg', 'title': 'Nutrition with Herbs'},
    ];

    return Scaffold(
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
      drawer: Nav(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              // Hero Section
              HeroSection(),

              SizedBox(height: 20),

              // Quick Access Avatars (Horizontal ListView)
              QuickAccessSection(),
              SizedBox(height: 20),

              SizedBox(height: 20),

              // Personalized Recommendations
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recommended for You",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              //product highlights
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      herbalMedicines.length < 4 ? herbalMedicines.length : 4,
                  itemBuilder: (context, index) {
                    final herb = herbalMedicines[index];
                    return HerbalProductCard(
                      id: herb['id'],
                      name: herb['name'],
                      usage: herb['usage'],
                      price: herb['price'],
                      currency: herb['currency'],
                      imageUrl: herb['image'],
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

              // Blog Highlights
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Latest Blog Articels",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 250, // Provide a fixed height instead of Expanded
                child: latestRemdies(),
              )
            ],
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
