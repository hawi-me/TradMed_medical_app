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

// void main() {
//   runApp(HerbApp());
// }

// class HerbApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HerbHome(),
//     );
//   }
// }
//  Container(
//                         width: 200,
//                         margin: EdgeInsets.symmetric(horizontal: 8),
//                         child: Card(
//                           elevation: 5,
//                           child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.network(medicine['image'],
//                                     height: 120, fit: BoxFit.cover),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   medicine['name'],
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                     'Price: ${medicine['price']} ${medicine['currency']}'),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),

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
      margin: EdgeInsets.symmetric(horizontal: 8),
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
            color: Colors.black.withOpacity(0.3),
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
                right: 10,
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
                  SizedBox(height: 20),
                  Center(
                    child: Image.network(
                      image ?? '',
                      width: width * 0.4,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    name ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 20),
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

// class HerbHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: Container(
//           height: 500,
//           width: width * 0.7,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 173, 223, 173),
//                 Color.fromARGB(255, 56, 142, 60),
//               ],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 3,
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: CustomPaint(
//               painter: HerbCardCustomPainter(),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 10,
//                     right: 10,
//                     child: Text(
//                       '\$5.99', // Price Tag
//                       style: TextStyle(
//                         color: Colors.green[900],
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(height: 20),
//                       Center(
//                         child: Image.asset(
//                           'assets/maint.png',
//                           width: width * 0.4,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'Mint Leaf',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: EdgeInsets.only(left: 10, right: 12),
//                         child: Text(
//                           'Mint is known for its cooling properties and refreshing aroma. It is widely used in food, drinks, and traditional medicine.',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           ),
//                           textAlign: TextAlign.center,
//                           softWrap: true,
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       detailWidget(
//                         text: 'Boosts Digestion',
//                       ),
//                       detailWidget(
//                         text: 'Soothing Aroma',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget detailWidget({ required String text}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Row(
//         children: [
//           Icon(
//             Icons.eco,
//             size: 24,
//             color: Colors.green[900],
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
