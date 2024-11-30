import 'package:flutter/material.dart';
import 'dart:ui';

class HerbCardCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 245, 247, 245)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.32);
    path.quadraticBezierTo(size.width * 0.24, size.height * 0.45,
        size.width * 0.49, size.height * 0.45);
    path.quadraticBezierTo(
        size.width * 0.73, size.height * 0.45, size.width, size.height * 0.32);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HerbHome extends StatelessWidget {
  final String? image;
  final String? name;
  final String? description;
  final String? price;
  final String? usage;

  HerbHome({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.usage,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: 200,
      height: 250, // Adjust the height here
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 173, 223, 173),
            Color.fromARGB(255, 2, 127, 127),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CustomPaint(
          painter: HerbCardCustomPainter(),
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Adds padding of 8 pixels on all sides
                  child: Text(
                    price ?? '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 15),
                  Center(
                    child: Image.network(
                      image ?? '',
                      width: width * 0.4,
                      height: 100, // Adjust the image height here
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 15), // Adjust spacing between elements
                  Text(
                    name ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, // Adjust text size here
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5), // Adjust spacing
                  detailWidget(text: usage ?? 'No usage information'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailWidget({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Icon(
            Icons.eco,
            size: 24,
            color: Colors.green[900],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HerbalProductCard extends StatelessWidget {
  final int id;
  final String name;
  final String usage;
  final double price;
  final String currency;
  final String imageUrl;

  HerbalProductCard({
    required this.id,
    required this.name,
    required this.usage,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HerbalProductDetailsPage(
              id: id,
              name: name,
              usage: usage,
              price: price,
              currency: currency,
              imageUrl: imageUrl,
              // Pass other details if needed
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    usage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5),
                  // Text(
                  //   '$price $currency',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.green[700],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
