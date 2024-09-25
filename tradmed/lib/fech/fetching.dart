import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Page to display the list of herbal medicines in a grid format.
class HerbalMedicineListPage extends StatefulWidget {
  @override
  _HerbalMedicineListPageState createState() => _HerbalMedicineListPageState();
}

class _HerbalMedicineListPageState extends State<HerbalMedicineListPage> {
  List herbalMedicines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHerbalMedicines(); // Fetch data when the page loads
  }

  // Function to fetch herbal medicines from API
  Future<void> fetchHerbalMedicines() async {
    try {
      // Replace with your API endpoint
      final response =
          await http.get(Uri.parse('http://192.168.2.187:8080/api/herb/'));

      if (response.statusCode == 200) {
        final List fetchedData = json.decode(response.body);
        setState(() {
          herbalMedicines = fetchedData;
          isLoading = false; // Data fetched successfully
        });
      } else {
        throw Exception('Failed to load herbal medicines');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Herbal Medicines'),
        actions: [
          // Search bar in the app bar
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: HerbalMedicineSearchDelegate(herbalMedicines),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                childAspectRatio:
                    0.7, // Adjust the aspect ratio for card height/width
                crossAxisSpacing: 10, // Horizontal spacing between cards
                mainAxisSpacing: 10, // Vertical spacing between cards
              ),
              itemCount: herbalMedicines.length,
              itemBuilder: (context, index) {
                final medicine = herbalMedicines[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HerbalMedicineDetailsPage(medicine: medicine),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              (medicine['Images'] != null &&
                                      medicine['Images'].isNotEmpty)
                                  ? medicine['Images']
                                  : 'https://ftn-image.s3-eu-west-1.amazonaws.com/ingredients/ginger-1.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'https://ftn-image.s3-eu-west-1.amazonaws.com/ingredients/ginger-1.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medicine['Name'] ?? 'Unknown',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: ${medicine['Price'] ?? 'N/A'} ${medicine['Currency'] ?? ''}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

// Custom search delegate to implement search functionality
class HerbalMedicineSearchDelegate extends SearchDelegate {
  final List herbalMedicines;

  HerbalMedicineSearchDelegate(this.herbalMedicines);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = herbalMedicines.where((medicine) {
      return medicine['Name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        childAspectRatio: 0.7, // Adjust the aspect ratio for card height/width
        crossAxisSpacing: 10, // Horizontal spacing between cards
        mainAxisSpacing: 10, // Vertical spacing between cards
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final medicine = results[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HerbalMedicineDetailsPage(medicine: medicine),
              ),
            );
          },
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      (medicine['Images'] != null &&
                              medicine['Images'].isNotEmpty)
                          ? medicine['Images']
                          : 'https://ftn-image.s3-eu-west-1.amazonaws.com/ingredients/ginger-1.png',
                      fit: BoxFit.cover,
                      width: double.infinity, // Make the image full width
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine['Name'] ?? 'Unknown',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Price: ${medicine['Price']} ${medicine['Currency']}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = herbalMedicines.where((medicine) {
      // Use 'Name' to match your data structure
      final name = medicine['Name']?.toLowerCase() ??
          ''; // Default to an empty string if null
      return name.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['Name'] ?? 'name'),
          onTap: () {
            query = suggestion['Name'] ??
                'name'; // Set query to the selected suggestion
            showResults(context); // Show results based on the suggestion
          },
        );
      },
    );
  }
}

class HerbalMedicineDetailsPage extends StatelessWidget {
  final dynamic medicine;

  const HerbalMedicineDetailsPage({Key? key, required this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine['Name'] ?? 'Unknown',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 2, 127, 127),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Displaying the image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  (medicine['Images'] != null && medicine['Images'].isNotEmpty)
                      ? medicine['Images']
                      : 'https://ftn-image.s3-eu-west-1.amazonaws.com/ingredients/ginger-1.png',
                ),
              ),
              SizedBox(height: 16),

              // Usage section
              Text(
                'Usage: ${medicine['Usage'] ?? 'N/A'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),

              // Price section
              Text(
                'Price: ${medicine['Price'] ?? 'N/A'} ${medicine['Currency'] ?? ''}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 16),

              // Side Effects section
              Text(
                'Side Effects:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              if (medicine['SideEffects'] != null &&
                  medicine['SideEffects'].isNotEmpty) ...[
                ...medicine['SideEffects'].map<Widget>((sideEffect) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '• $sideEffect',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '• No known side effects',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
              SizedBox(height: 16),

              // Nearby Shops section
              Text(
                'Nearby Shops:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (medicine['NearbyShops'] != null &&
                  medicine['NearbyShops'].isNotEmpty) ...[
                ...medicine['NearbyShops'].map<Widget>((shop) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shop Name: ${shop['ShopName'] ?? 'N/A'}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Address: ${shop['Address'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Contact: ${shop['contact'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No nearby shops found.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
