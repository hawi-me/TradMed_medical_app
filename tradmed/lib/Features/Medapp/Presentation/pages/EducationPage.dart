// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:tradmed/widgets/nav_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Educationpage extends StatefulWidget {
  const Educationpage({super.key});

  @override
  State<Educationpage> createState() => _EducationpageState();
}

class _EducationpageState extends State<Educationpage> {
  int _selectedIndex = 1;
  List<bool> isPlaying = [];

  final List<String> videoUrls = [
    'https://youtu.be/_zlKpm6wGaQ?si=4sOku-R0pH3hRZRl',
    'https://youtu.be/1Uq_7Gm6zQk?si=8zf4QqYML32VpK4u',
    'https://youtu.be/F06wSDOyIqM?si=0VQ2NsCB8lUYJW5X',
    'https://youtu.be/wyOIDoh14pk?si=9fuGZCHMYjrr5b0a',
    'https://youtu.be/xKEylDUTQXM?si=8nz9mcrmo_yzAlTV',
    'https://youtu.be/OkyIlN1-LKk?si=zGPgmTR_GCl656LT',
    'https://youtu.be/tMkWdGX1Res?si=c1P0tqgRWOHJylEA',
    'https://youtu.be/yyMBKfEXUUI?si=JswOTw11a1PqTMVu',
    'https://youtu.be/V4Fj92AADcI?si=0xyKJ-oow7YQH1xy',
  ];

  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each video
    _controllers = videoUrls
        .map((url) => YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(url)!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                enableCaption: false,

                // mute: false,
                // forceHD: true,
                // disableDragSeek: false,
                // hideControls: false,
              ),
            ))
        .toList();

    // Initialize all videos to 'not playing' state
    isPlaying = List.generate(videoUrls.length, (index) => false);
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/homepage');
        break;
      case 1:
        // Do nothing, already on Education page
        break;
      case 2:
        Navigator.pushNamed(context, '/telemedicinepage');
        break;
      case 3:
        Navigator.pushNamed(context, '/aihomepage');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  'Special For You',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 127, 127)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _controllers.length,
                  itemBuilder: (context, index) {
                    // Get the video ID and thumbnail URL then interchange b/n this states for pause and continue
                    final videoId =
                        YoutubePlayer.convertUrlToId(videoUrls[index])!;
                    final thumbnailUrl =
                        'https://img.youtube.com/vi/$videoId/0.jpg';

                    return Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlaying[index] = !isPlaying[index];
                            if (!isPlaying[index]) {
                              _controllers[index].pause();
                            }
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: isPlaying[index]
                              ? YoutubePlayer(
                                  controller: _controllers[index],
                                  showVideoProgressIndicator: true,
                                  bottomActions: [
                                    CurrentPosition(),
                                    FullScreenButton(),
                                    ProgressBar(
                                      isExpanded: true,
                                      colors: ProgressBarColors(
                                        playedColor: Colors.red,
                                        handleColor: Colors.white,
                                      ),
                                    ),
                                    // FullScreenButton(),
                                  ],
                                )
                              : Image.network(
                                  thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
