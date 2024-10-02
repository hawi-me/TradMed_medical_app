import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/fech/fetching.dart';
import 'package:tradmed/widgets/card.dart';
import 'package:tradmed/widgets/herosection.dart';
import 'package:tradmed/widgets/nav_bar.dart';

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
      appBar: AppBar(),
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
              SizedBox(
                height: 90, // Set height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: quickAccess.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          // Handle navigation or functionality for each quick access item
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30, // Size of the avatar
                              backgroundImage: AssetImage(quickAccess[index]
                                  ['icon']!), // Image for the avatar
                            ),
                            SizedBox(height: 8),
                            Text(
                              quickAccess[index]['label']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

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
                  "Latest Blog Posts",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: Blogs.map((blog) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          blog['image']!,
                          width: 60,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(blog['title']!),
                      subtitle: Text("A brief snippet of the blog post..."),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigate to full blog post
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 1, 101, 126),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
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
