import 'package:audioplayers/audioplayers.dart';
import 'package:cs486/SettingPage.dart';
import 'package:cs486/Song.dart';
import 'package:cs486/database.dart';
import 'package:flutter/material.dart';

class LikedTrackPage extends StatefulWidget {
  late AudioPlayer audioPlayer;
  List<Song>meditation = [];
  List<Song>study = [];
  List<Song>workout = [];
  List<Song>sleep = [];
  List<Song>liked = [];
  List<Song>added = [];
  LikedTrackPage({super.key,required this.audioPlayer});

  @override
  State<LikedTrackPage> createState() => _LikedTrackPageState();
}

class _LikedTrackPageState extends State<LikedTrackPage> {
  @override
  void initState(){
    super.initState();
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
                  list_name: 'Liked',
                  playlist: widget.liked,
                  audioPlayer: AudioPlayer(), liked: widget.liked,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>SettingPage(audioPlayer: widget.audioPlayer),
                          ));
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 50,
                      color: Colors.white,
                    ))),
          )
        ],
      )),
    );
  }
}
