// custom_bottom_navbar.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

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
          icon: Icon(Icons.psychology),
          label: AppLocalizations.of(context)!.bottomAi,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 2, 127, 127),
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
