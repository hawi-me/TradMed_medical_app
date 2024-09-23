// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Nav extends StatelessWidget {
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
                // backgroundColor: Colors.red,
                child: ClipOval(
                  child: Image.asset(
                    width: 90,
                    height: 90,
                    "assets/UserProfile.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          ListTile(
              leading: Icon(Icons.search), title: Text("Search"), onTap: () {}),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Education"),
            onTap: () {
              Navigator.pushNamed(context, '/educationpage');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Setting"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favorite"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
