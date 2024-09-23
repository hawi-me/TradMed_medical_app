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

          prefixIcon: Icon(Icons.search, color: Colors.green[700]),

          filled: true,
          fillColor:
              Colors.green[50], 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20), 
            borderSide: BorderSide.none, 
          ),

          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),

        style: TextStyle(color: Colors.green[900], fontSize: 16),
      ),
    );
  }
}
