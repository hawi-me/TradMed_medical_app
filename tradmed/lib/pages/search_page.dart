import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiseaseSearchScreen(),
    );
  }
}

class DiseaseSearchScreen extends StatefulWidget {
  @override
  _DiseaseSearchScreenState createState() => _DiseaseSearchScreenState();
}

class _DiseaseSearchScreenState extends State<DiseaseSearchScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _results = [];

  Future<void> searchDisease(String diseaseName) async {
    print("Searching for disease: $diseaseName");
    final url = 'http://192.168.2.187:8080/api/disease/$diseaseName'; // API URL
    try {
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _results = [
            {
              'name': data['Name'],
              'description': data['Description'],
              'symptoms': data['Symptoms'],
              'treatment': data['Treatment'],
              'prevention': data['Prevention'],
              'images': data['Images'],
            }
          ];
        });
      } else {
        setState(() {
          _results = [];
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        _results = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(controller: _controller),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                searchDisease(_controller.text);
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _results.isEmpty
                  ? Center(child: Text('No results found'))
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to Details Page when a card is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiseaseDetailsPage(
                                  name: _results[index]['name'],
                                  description: _results[index]['description'],
                                  symptoms: _results[index]['symptoms'],
                                  treatment: _results[index]['treatment'],
                                  prevention: _results[index]['prevention'],
                                  image: _results[index]['images'],
                                ),
                              ),
                            );
                          },
                          child: DiseaseCard(
                            name: _results[index]['name'],
                            description: _results[index]['description'],
                            symptoms: _results[index]['symptoms'],
                            image: _results[index]['images'],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Disease Card Widget
class DiseaseCard extends StatelessWidget {
  final String name;
  final String description;
  final List<dynamic> symptoms;
  final String image;

  const DiseaseCard({
    Key? key,
    required this.name,
    required this.description,
    required this.symptoms,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 10),
            image.isNotEmpty
                ? Image.network(image, height: 100, fit: BoxFit.cover)
                : Container(), 
            SizedBox(height: 10),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              'Symptoms: ${symptoms.join(", ")}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// Disease Details Page
class DiseaseDetailsPage extends StatelessWidget {
  final String name;
  final String description;
  final List<dynamic> symptoms;
  final String treatment;
  final String prevention;
  final String image;

  const DiseaseDetailsPage({
    Key? key,
    required this.name,
    required this.description,
    required this.symptoms,
    required this.treatment,
    required this.prevention,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image.isNotEmpty
                ? Image.network(image, height: 200, fit: BoxFit.cover)
                : Container(), // Show image if available
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Text(
              'Symptoms: ${symptoms.join(", ")}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Text(
              'Treatment: $treatment',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Text(
              'Prevention: $prevention',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// SearchBar Widget
class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const SearchBar({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search for a disease...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(Icons.search, color: Colors.green[700]),
          filled: true,
          fillColor: Colors.green[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),
        style: TextStyle(color: Colors.green[900], fontSize: 16),
      ),
    );
  }
}
