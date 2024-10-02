// custom_bottom_navbar.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context)!.bottomHome,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: AppLocalizations.of(context)!.bottomEducation,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: AppLocalizations.of(context)!.bottomTelemed,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/herbal_bot.png'),
            size: 60.0, // Path to your image
          ),
          label: AppLocalizations.of(context)!.bottomAi,
        ),
      ],
      currentIndex: selectedIndex,
      unselectedItemColor: const Color.fromARGB(255, 2, 127, 127),
      selectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
