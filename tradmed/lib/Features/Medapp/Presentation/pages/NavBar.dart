// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication import
import 'chatscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Nav extends StatelessWidget {
  const Nav({super.key});

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
            accountName: Text("John Doe"),
            accountEmail: Text("Johndoe@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  width: 90,
                  height: 90,
                  "assets/UserProfile.jpg",
                  fit: BoxFit.cover,
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
