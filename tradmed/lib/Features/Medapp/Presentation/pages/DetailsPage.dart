// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Detailspage extends StatelessWidget {
  const Detailspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/Details image.jfif',
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aloe Vera Extract '), //name
                      SizedBox(
                        height: 5,
                      ),
                      Text(//description
                          'Aloe Vera Extract is a natural supplement known for its powerful immune-boosting properties and skin health benefits.'),

                      SizedBox(
                        height: 15,
                      ),

                      Text('Benefits:'), //Benefits
                      Text('- Boosts immune system'),
                      Text('-Promotes healthy skin and hair'),
                      Text('-Supports digestion'),
                      Text('-Provides anti-inflammatory benefits'),
                      SizedBox(
                        height: 15,
                      ),

                      Text('Indgredients:'),
                      Text(
                          '-Aloe Vera Extract: Known for soothing and healing properties.'),
                      Text('-Provides antioxidant protection.'),
                      Text(
                          '-Natural Oils: Help hydrate and rejuvenate the skin.'),
                      SizedBox(
                        height: 15,
                      ),

                      Text('Usage Instructions:'),
                      Text(
                          '-Take 1 teaspoon daily with water, preferably in the morning.'),
                      Text(
                          '-Can also be applied topically for skin hydration.'),
                      SizedBox(
                        height: 15,
                      ),

                      Text('Side Effects:'),
                      Text(
                          '-Not recommended for individuals allergic to Aloe Vera.'),
                      Text(
                          '-Pregnant or breastfeeding women should consult a doctor before use.'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
