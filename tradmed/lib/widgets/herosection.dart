import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tradmed/pages/searchresult.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeroSection extends StatefulWidget {
  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedSearchType = 'herb'; // Default search type
  TextEditingController _controller = TextEditingController();

  List<String> images = [
    'assets/herbal_im.jpeg',
    'assets/herbal_doc.jpeg',
    'assets/organic.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  // Perform the search based on the selected filter and query
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
    // Move textContent here to ensure context is available
    List<Map<String, String>> textContent = [
      {
        'title': AppLocalizations.of(context)!.homeHero,
        'subtitle': AppLocalizations.of(context)!.homeDynamic1,
        'buttonText': AppLocalizations.of(context)!.homeDynamicDetail1,
      },
      {
        'title': AppLocalizations.of(context)!.homeDynamic2,
        'subtitle': AppLocalizations.of(context)!.homeDynamicDetail2,
        'buttonText': AppLocalizations.of(context)!.homeDynamic3,
      },
      {
        'title': AppLocalizations.of(context)!.homeDynamicDetail3,
        'subtitle': AppLocalizations.of(context)!.homeDynamic4,
        'buttonText': AppLocalizations.of(context)!.homeDynamicDetail4,
      },
    ];

    return Container(
      height: 300,
      child: Stack(
        children: [
          // PageView for sliding content
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 101, 126)
                        .withOpacity(0.6), // Light overlay
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          textContent[index]['title']!,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          textContent[index]['subtitle']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press here
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            textContent[index]['buttonText']!,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Search and filter bar
          Positioned(
            top: 16,
            left: 16,
            right: 16, // Add right padding to keep the search bar aligned
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    Navigator.pushNamed(context, '/navbar');
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/UserProfile.jpg'),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Search field
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              hintText: _selectedSearchType == 'herb'
                                  ? 'Search for herbs...'
                                  : 'Search for diseases...',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.green),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.mic, color: Colors.green),
                                onPressed: () {
                                  // Implement voice search functionality here
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) => _performSearch(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    size: 30,
                    color: Colors.white, // Adjust color for visibility
                  ),
                  onPressed: () {
                    _showFilterDialog(); // Function to display filter dialog
                  },
                ),
              ],
            ),
          ),
          // Page indicators
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display a filter dialog for search options
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search by:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: 'herb',
                groupValue: _selectedSearchType,
                title: Text('Herb'),
                onChanged: (value) {
                  setState(() {
                    _selectedSearchType = value!;
                  });
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
              RadioListTile<String>(
                value: 'disease',
                groupValue: _selectedSearchType,
                title: Text('Disease'),
                onChanged: (value) {
                  setState(() {
                    _selectedSearchType = value!;
                  });
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
