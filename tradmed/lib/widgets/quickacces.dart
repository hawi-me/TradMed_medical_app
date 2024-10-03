import 'package:flutter/material.dart';

// Example quickAccess data
final List<Map<String, String>> quickAccess = [
  {
    'icon': 'assets/log_1.png',
    'label': 'Herbs',
    'route': '/herbs',
  },
  {
    'icon': 'assets/herbal_bot.png',
    'label': 'Remedies',
    'route': '/educationpage',
  },
  {
    'icon': 'assets/telemed.png',
    'label': 'Consult',
    'route': '/telemedicinepage',
  },
  {
    'icon': 'assets/undraw_Blogging_re_kl0d.png',
    'label': 'Blog',
    'route': '/blog',
  },
];

class QuickAccessSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Adjust height for more spacing
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickAccess.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {
                // Handle navigation for each quick access item
                Navigator.pushNamed(context, quickAccess[index]['route']!);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent.shade100, Colors.teal.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20), // Smooth rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.shade100.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5), // Depth shadow
                    ),
                  ],
                ),
                width: 120, // Increased width for better layout
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Replace CircleAvatar with Image icon
                    Container(
                      height: 60, // Larger height for the image
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(quickAccess[index]['icon']!),
                          fit: BoxFit.contain, // Ensure the image fits
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Space between image and label
                    Text(
                      quickAccess[index]['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Larger font size
                        fontWeight: FontWeight.w700, // Bolder text
                        color: Colors.white, // White text to contrast gradient
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
