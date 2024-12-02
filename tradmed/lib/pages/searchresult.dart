import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchResultsPage extends StatefulWidget {
  final String query;
  final String is_value;

  const SearchResultsPage(
      {Key? key, required this.query, required this.is_value})
      : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<Map<String, dynamic>> _results = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    // Determine which search to perform based on `is_value`
    if (widget.is_value == "disease") {
      searchDisease(widget.query);
    } else if (widget.is_value == "herb") {
      searchHerb(widget.query);
    }
  }

  Future<void> searchHerb(String herbName) async {
    final url = 'https://go-backend-1-cu7n.onrender.com/api/herb/$herbName';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _results = [
            {
              'name': data['Name'] ?? 'Unknown',
              'usage': data['Usage'] ?? 'No usage information available.',
              'price': data['Price']?.toString() ?? 'Price not available',
              'currency': data['Currency'] ?? 'USD',
              'side_effects': data['Side_effects'] ?? [],
              'images': data['Images'] ?? '',
              'nearby_shops': data['Nearby_shops'] ?? [],
            }
          ];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Failed to load data. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error: $error';
        _isLoading = false;
      });
    }
  }

  Future<void> searchDisease(String diseaseName) async {
    final url =
        'https://go-backend-1-cu7n.onrender.com/api/disease/$diseaseName';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _results = [
            {
              'name': data['Name'] ?? 'Unknown',
              'description': data['Description'] ?? 'No description available.',
              'symptoms': data['Symptoms'] ?? [],
              'treatment': data['Treatment'] ?? 'No treatment available.',
              'prevention':
                  data['Prevention'] ?? 'No prevention info available.',
              'images': data['Images'] ?? '',
            }
          ];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Failed to load data. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "${widget.query}"'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : _results.isEmpty
                    ? Center(
                        child: Text('No results found for "${widget.query}"'))
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          if (widget.is_value == "herb") {
                            return HerbCard(
                              name: _results[index]['name'],
                              usage: _results[index]['usage'],
                              price: _results[index]['price'],
                              currency: _results[index]['currency'],
                              sideEffects: _results[index]['side_effects'],
                              image: _results[index]['images'] ?? '', benefits: [], precautions: '',
                            );
                          } else if (widget.is_value == "disease") {
                            return DiseaseCard(
                              name: _results[index]['name'],
                              description: _results[index]['description'],
                              symptoms: _results[index]['symptoms'],
                              image: _results[index]['images'],
                            );
                          } else {
                            return Container(); // Fallback, should not reach here
                          }
                        },
                      ),
      ),
    );
  }
}

// HerbCard Widget

class HerbCard extends StatelessWidget {
  final String name;
  final String usage;
  final String price;
  final String currency;
  final List<dynamic> sideEffects;
  final String image;
  final List<dynamic> benefits;
  final String precautions;

  const HerbCard({
    Key? key,
    required this.name,
    required this.usage,
    required this.price,
    required this.currency,
    required this.sideEffects,
    required this.image,
    required this.benefits,
    required this.precautions,
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
            // Herb Name
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 10),
            // Herb Image
            image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(image, height: 120, fit: BoxFit.cover),
                  )
                : Container(),
            const SizedBox(height: 10),
            // Usage Information
            Text(
              'Usage: $usage',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            // Price
            Text(
              'Price: $price $currency',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Benefits
            if (benefits.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Benefits:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    benefits.join(", "),
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            // Side Effects
            if (sideEffects.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Side Effects:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                  Text(
                    sideEffects.join(", "),
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            // Precautions
            if (precautions.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Precautions:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  Text(
                    precautions,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            const SizedBox(height: 15),
            // Action Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to detailed view or perform an action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DiseaseCard Widget
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
            Text('Description: $description'),
            Text('Symptoms: ${symptoms.join(", ")}'),
          ],
        ),
      ),
    );
  }
}
