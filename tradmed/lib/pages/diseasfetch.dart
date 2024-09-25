import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiseaseListPage extends StatefulWidget {
  @override
  _DiseaseListPageState createState() => _DiseaseListPageState();
}

class _DiseaseListPageState extends State<DiseaseListPage> {
  List<dynamic> diseases = [];
  int currentPage = 1;
  final int totalPages = 5; // Adjust based on your API

  @override
  void initState() {
    super.initState();
    fetchDiseases(currentPage); // Fetch data for the initial page
  }

  Future<void> fetchDiseases(int page) async {
    final url = 'http://192.168.2.187:8080/api/disease/p/$page';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          diseases = json.decode(response.body);
        });
      } else {
        // Handle error response
        throw Exception('Failed to load diseases');
      }
    } catch (e) {
      // Handle network or parsing errors
      print(e);
      // Optionally show a Snackbar or dialog to the user
    }
  }

  void goToPage(int page) {
    setState(() {
      currentPage = page;
    });
    fetchDiseases(currentPage); // Fetch data for the selected page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                final disease = diseases[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          disease['Name'] ??
                              'Unknown Disease', // Safe access to 'Name'
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          disease['Description'] ??
                              'No description available.', // Safe access to 'Description'
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Symptoms: ${disease['Symptoms']?.join(', ') ?? 'No symptoms listed.'}', // Safe access to 'Symptoms'
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Treatment: ${disease['Treatment'] ?? 'No treatment information available.'}', // Safe access to 'Treatment'
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Prevention: ${disease['Prevention'] ?? 'No prevention information available.'}', // Safe access to 'Prevention'
                        ),
                        SizedBox(height: 10),
                        if (disease['Images'] !=
                            null) // Check if image URL exists
                          Image.network(
                            disease['Images'],
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Page navigation buttons

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: currentPage > 1
                    ? () => goToPage(currentPage - 1)
                    : null, // Disable if on first page
              ),
              Text('Page $currentPage of $totalPages'), // Display current page
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: currentPage < totalPages
                    ? () => goToPage(currentPage + 1)
                    : null, // Disable if on last page
              ),
            ],
          ),
        ],
      ),
    );
  }
}
