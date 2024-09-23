import 'package:flutter/material.dart';
 class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // Method to handle bottom navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 2, 127, 127),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
  );
  }
}

