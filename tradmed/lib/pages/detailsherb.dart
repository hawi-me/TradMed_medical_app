import 'package:flutter/material.dart';

class HerbalProductDetailsPage extends StatelessWidget {
  final int id;
  final String name;
  final String usage;
  final double price;
  final String currency;
  final String imageUrl;
  // You can pass other details such as side effects and nearby shops

  HerbalProductDetailsPage({
    required this.id,
    required this.name,
    required this.usage,
    required this.price,
    required this.currency,
    required this.imageUrl,
    // Initialize other details if passed
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  imageUrl,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Usage: $usage',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Price: $price $currency',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Side Effects',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              // Display side effects (dummy data for now)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Side Effect 1'),
                  Text('• Side Effect 2'),
                  Text('• Side Effect 3'),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Nearby Shops',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              // Display nearby shops (dummy data for now)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shop 1: Address, Contact'),
                  Text('Shop 2: Address, Contact'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
