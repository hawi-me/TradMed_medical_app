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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Education',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'Telemedicine',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.psychology),
          label: 'AI',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 2, 127, 127),
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
