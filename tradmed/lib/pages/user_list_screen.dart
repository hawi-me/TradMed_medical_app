import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:tradmed/widgets/nav_bar.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int _selectedIndex = 2; // Set default to Telemedicine index (2)

  // Search query for searching users
  String searchQuery = '';

  // List of random profile pictures stored locally
  final List<String> profilePictures = [
    'assests/images/image1.png',
    'assests/images/image2.png',
    'assests/images/image3.png',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/homepage'); // Navigate to Home
        break;
      case 1:
        Navigator.pushNamed(context, '/educationpage'); // Navigate to Education
        break;
      case 2:
        // No need to navigate as we're already on the Telemedicine page
        break;
      case 3:
        Navigator.pushNamed(context, '/aihomepage'); // Navigate to AI
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a User to Chat'),
      ),
      drawer: const Nav(), // Add Nav sidebar (drawer)
      body: Column(
        children: [
          // Search Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for users by email...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.green[700]),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery =
                        value.toLowerCase(); // Update the search query
                  });
                },
              ),
            ),
          ),

          // User List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs;
                List<ListTile> userTiles = [];

                for (var user in users) {
                  final userData = user.data() as Map<String, dynamic>;

                  // Ensure that the 'email' field exists and is not empty
                  if (userData.containsKey('email') &&
                      userData['email'] != null &&
                      userData['email'].isNotEmpty) {
                    final userEmail = userData['email'];

                    // Filter based on search query
                    if (searchQuery.isNotEmpty &&
                        !userEmail.toLowerCase().contains(searchQuery)) {
                      continue;
                    }

                    // Pick a random profile picture for the user
                    final randomProfilePicture =
                        (profilePictures..shuffle()).first;

                    userTiles.add(
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(randomProfilePicture),
                        ),
                        title: Text(userEmail),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(receiverEmail: userEmail),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }

                return ListView(
                  children: userTiles,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
