// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Detailarticlespage extends StatefulWidget {
  final String title;
  final String description1;
  final String description2;
  final String description3;
  final String imageUrl;

  const Detailarticlespage({
    super.key,
    required this.title,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.imageUrl,
  });

  @override
  _DetailarticlespageState createState() => _DetailarticlespageState();
}

class _DetailarticlespageState extends State<Detailarticlespage> {
  bool isFavorite =
      false; // State variable to track if the article is favorited

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade200,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
                height: 250,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                height: 500,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 250,
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ),
                                Text(
                                  'Health',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite // Filled heart if favorite
                                  : Icons.favorite_border_outlined,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorite =
                                    !isFavorite; // Toggle favorite state
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Column(
                                children: [
                                  Text(widget.description1),
                                  SizedBox(height: 10),
                                  Text(widget.description2),
                                  SizedBox(height: 10),
                                  Text(widget.description3),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
