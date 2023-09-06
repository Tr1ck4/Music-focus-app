// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';
import 'package:cs486/AddedSongPage.dart';
import 'package:cs486/LikeSongPage.dart';
import 'package:cs486/LikedTrackPage.dart';
import 'package:cs486/MeditationPage.dart';
import 'package:cs486/PlaylistPage.dart';
import 'package:cs486/SleepPage.dart';
import 'package:cs486/Song.dart';
import 'package:cs486/StudyPage.dart';
import 'package:cs486/WorkoutPage.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class PlaylistSongPage extends StatefulWidget {
  List<Song>meditation = [];
  List<Song>study = [];
  List<Song>workout = [];
  List<Song>sleep = [];
  List<Song>liked = [];
  List<Song>added = [];
  final String list_name;
  final List<Song> name;
  PlaylistSongPage({required this.list_name, required this.name, super.key});

  @override
  State<PlaylistSongPage> createState() => _PlaylistSongPageState();
}

class _PlaylistSongPageState extends State<PlaylistSongPage> {
  void callData()async{
    widget.meditation = await DBProvider().readPlaylist("Meditation");
    widget.study = await DBProvider().readPlaylist("Study");
    widget.sleep = await DBProvider().readPlaylist("Sleep");
    widget.workout = await DBProvider().readPlaylist("Workout");
    widget.liked = await DBProvider().readLiked();
    widget.added = await DBProvider().readPlaylist("Added");
  }
  @override
  void initState(){
    super.initState();
    callData();
  }
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
                  audioPlayer: AudioPlayer(),liked: widget.liked,
              ),
          ),
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
                                builder: (context) => PlaylistPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),
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
                                          MeditationPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked,)));
                            }
                            if (widget.list_name == 'Workout') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WorkoutPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked)));
                            }
                            if (widget.list_name == 'Study') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudyPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked)));
                            }
                            if (widget.list_name == 'Sleep') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SleepPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked)));
                            }
                            if (widget.list_name == 'Liked Tracks') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LikedSongPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked)));
                            }
                            if (widget.list_name == 'Added Tracks') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddedSongPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked)));
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
