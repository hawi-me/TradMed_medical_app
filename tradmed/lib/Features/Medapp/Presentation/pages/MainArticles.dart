// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:convert'; // Import for json
import 'package:flutter/services.dart';
import 'package:tradmed/Features/Medapp/Data/models/article_model.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/DetailArticlesPage.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart'; // Import for rootBundle

class Mainarticles extends StatefulWidget {
  const Mainarticles({super.key});

  @override
  _MainarticlesState createState() => _MainarticlesState();
}

class _MainarticlesState extends State<Mainarticles> {
  late Future<Articles> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = loadArticles();
  }

  Future<Articles> loadArticles() async {
    final String response = await rootBundle.loadString('assets/Articles.json');
    final data = json.decode(response);
    return Articles.fromJson(data['articles']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Articles>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.articles.isEmpty) {
            return Center(child: Text('No articles found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.articles.length,
              itemBuilder: (context, index) {
                final article = snapshot.data!.articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailarticlespage(
                            title: article.title,
                            description1: article.description1,
                            description2: article.description2,
                            description3: article.description3,
                            imageUrl: article.imageUrl),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(article.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                child: Text(
                                  article.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    // color: Colors.green.shade400,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Health',
                                    style: TextStyle(
                                      // color: Colors.grey.shade600,
                                      color: Colors.green.shade400,

                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Row(
                                    children: [
                                      Text(
                                        '• ',
                                        style: TextStyle(
                                          // color: Colors.grey.shade600,
                                          color: Colors.green.shade400,

                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        '10m ago',
                                        style: TextStyle(
                                          // color: Colors.grey.shade600,
                                          color: Colors.green.shade400,

                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
