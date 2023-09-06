import 'package:audioplayers/audioplayers.dart';
import 'package:cs486/SettingPage.dart';
import 'package:flutter/material.dart';
import 'Song.dart';
import 'database.dart';

class PlaylistPage extends StatefulWidget {
  late AudioPlayer audioPlayer;
  List<Song>meditation = [];
  List<Song>study = [];
  List<Song>workout = [];
  List<Song>sleep = [];
  List<Song>liked = [];
  List<Song>added = [];
  List<Playlist>album = [];
  PlaylistPage({super.key,required this.audioPlayer,required this.meditation,required this.study,required this.workout, required this.sleep, required this.added,required this.liked});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  void callData()async{
    widget.meditation = await DBProvider().readPlaylist("Meditation");
    widget.study = await DBProvider().readPlaylist("Study");
    widget.workout = await DBProvider().readPlaylist("Workout");
    widget.sleep = await DBProvider().readPlaylist("Sleep");
    widget.liked = await DBProvider().readLiked();
    widget.added = await DBProvider().readPlaylist("Added");
    setState(() {
      widget.album = [
        Playlist(list_name: 'Meditation', playlist: widget.meditation, audioPlayer: AudioPlayer(),liked: widget.liked,),
        Playlist(list_name: 'Sleep', playlist: widget.sleep, audioPlayer: AudioPlayer(),liked: widget.liked),
        Playlist(list_name: 'Workout', playlist: widget.workout, audioPlayer: AudioPlayer(),liked: widget.liked),
        Playlist(list_name: 'Study', playlist: widget.study, audioPlayer: AudioPlayer(),liked: widget.liked),
        Playlist(list_name: 'Liked Tracks', playlist: widget.liked, audioPlayer: AudioPlayer(),liked: widget.liked),
        Playlist(list_name: 'Added Tracks', playlist: widget.added, audioPlayer: AudioPlayer(),liked: widget.liked)
      ];
    });
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
              child: Album(audioPlayer: widget.audioPlayer,album_name: 'Default', album: widget.album,meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingPage(audioPlayer: widget.audioPlayer),
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
