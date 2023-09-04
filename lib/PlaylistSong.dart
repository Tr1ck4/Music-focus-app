// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';
import 'package:cs486/AddedSongPage.dart';
import 'package:cs486/LikedTrackPage.dart';
import 'package:cs486/MeditationPage.dart';
import 'package:cs486/PlaylistPage.dart';
import 'package:cs486/SleepPage.dart';
import 'package:cs486/Song.dart';
import 'package:cs486/StudyPage.dart';
import 'package:cs486/WorkoutPage.dart';
import 'package:flutter/material.dart';

class PlaylistSongPage extends StatefulWidget {
  final String list_name;
  final List<Song> name;
  const PlaylistSongPage(
      {required this.list_name, required this.name, super.key});

  @override
  State<PlaylistSongPage> createState() => _PlaylistSongPageState();
}

class _PlaylistSongPageState extends State<PlaylistSongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Settingpage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(40),
              child: Playlist(
                  list_name: widget.list_name,
                  playlist: widget.name,
                  audioPlayer: AudioPlayer())),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PlaylistPage(),
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 50,
                          color: Colors.white,
                        ))),
                Visibility(
                  visible: widget.name.isNotEmpty,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                          onPressed: () {
                            if (widget.list_name == 'Meditation') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MeditationPage()));
                            }
                            if (widget.list_name == 'Workout') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WorkoutPage()));
                            }
                            if (widget.list_name == 'Study') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const StudyPage()));
                            }
                            if (widget.list_name == 'Sleep') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SleepPage()));
                            }
                            if (widget.list_name == 'Liked Tracks') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LikedTrackPage()));
                            }
                            if (widget.list_name == 'Added Tracks') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddedSongPage()));
                            }
                          },
                          icon: const Icon(
                            Icons.music_note,
                            size: 50,
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
