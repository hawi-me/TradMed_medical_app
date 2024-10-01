// custom_bottom_navbar.dart
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Education',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'Telemedicine',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/herbal_bot.png'),
            size: 60.0, // Path to your image
          ),
          label: 'AI',
        ),
      ],
      currentIndex: selectedIndex,
      unselectedItemColor: const Color.fromARGB(255, 2, 127, 127),
      selectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
