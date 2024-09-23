import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for herbal products...',
          hintStyle: TextStyle(color: Colors.grey[600]),

          // Add a search icon inside the text field
          prefixIcon: Icon(Icons.search, color: Colors.green[700]),

          // Rounded borders
          filled: true,
          fillColor:
              Colors.green[50], // Light background color for the input field
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            borderSide: BorderSide.none, // No outline border
          ),

          // Add some padding around the text
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),

        // Customize the style of the text
        style: TextStyle(color: Colors.green[900], fontSize: 16),
      ),
    );
  }
}
