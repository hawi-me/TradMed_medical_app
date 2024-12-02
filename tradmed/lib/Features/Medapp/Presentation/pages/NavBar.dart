import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  String? username;
  String? email;
  String? usern;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        setState(() {
          email = currentUser.email;
        });

        // Fetch username from Firestore if available
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        setState(() {
          username = userDoc.data()?['username'] ?? 'Guest User';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading user data: $e'),
        ),
      );
    }
  }

  Future<void> _deleteCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // Delete email and password from SharedPreferences after logout
      await _deleteCredentials();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('username');

      // Redirect to login screen
      Navigator.of(context).pushReplacementNamed('/auth');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logout failed: $e"),
        ),
      );
    }
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Fetch the username from SharedPreferences, default to 'Guest' if not found
      username = prefs.getString('username') ?? 'Guest';

      // Check if the username has at least 6 characters
      if (username!.length >= 6) {
        usern = username!.substring(0, 6); // Slice the first 6 characters
        print(usern); // Print the sliced username
      } else {
        print('The username is too short.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/breezy.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text(usern ?? 'Loading...'),
            accountEmail: Text(email ?? 'Loading...'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/UserProfile.jpg",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.search),
              title: Text(AppLocalizations.of(context)!.navSearch),
              onTap: () {}),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text(AppLocalizations.of(context)!.navEducation),
            onTap: () {
              Navigator.pushNamed(context, '/educationpage');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(AppLocalizations.of(context)!.navShare),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text("Blogs"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogChatScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(AppLocalizations.of(context)!.navFavorites),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              AppLocalizations.of(context)!.navLogout,
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              _logout(context); // Call the logout function
            },
          ),
        ],
      ),
    );
  }
}
