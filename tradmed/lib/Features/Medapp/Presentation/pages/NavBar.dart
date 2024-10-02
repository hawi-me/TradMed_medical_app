// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'chatscreen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Nav extends StatelessWidget {
  const Nav({super.key});

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
                  builder: (context) =>
                      BlogChatScreen(),
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
