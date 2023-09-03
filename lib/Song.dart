import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Song{
  final String name;
  final String asset;
  Song(this.name, this.asset);
}

List<Song> meditation =  [Song('Forest sounds','audio/Meditation/forest_sounds.mp3'),Song('Waterfall sounds', 'audio/Meditation/waterfall_sounds.mp3')];
List<Song> sleep =  [Song('Sleeping City','audio/Sleep/SleepingCity_JayLounge.mp3'),Song('WYS', 'audio/Sleep/WYS_LoneftEase.mp3')];
List<Song> workout =  [Song('Conquer','audio/Workout/Conquer_Hopex.mp3'),Song('IDidThatDiamond_Ortiz', 'audio/Workout/IDidThatDiamond_Ortiz.mp3')];
List<Song> study =  [Song('Causes_geek','audio/Study/Causes_geek.mp3'),Song('VoiceOfTheForest_YasumuxNo', 'audio/Study/VoiceOfTheForest_YasumuxNo Spirit.mp3')];

class Playlist extends StatefulWidget{
  final AudioPlayer audioPlayer;
  final String list_name;
  final List<Song> playlist ;
  const Playlist({super.key, required this.list_name, required this.playlist,required this.audioPlayer});
  @override
  State<Playlist> createState()=>_PlaylistState();
}
class _PlaylistState extends State<Playlist>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          itemCount: widget.playlist.length,
          itemBuilder: (context, index) => Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white,width: 2))
            ),
            child:ListTile(
                title: Text(widget.playlist[index].name),
              onTap: () async{
                setState(() {
                  widget.audioPlayer.play(AssetSource(widget.playlist[index].asset));
                });
              },
            )
          )
    );
  }
}


// List<Playlist> storage = [
//   Playlist(list_name: 'meditation', playlist: meditation)
// ];

class Playlist2 extends StatefulWidget {
  final String list_name;
  final List<Song> playlist;

  int numSong() {
    int songs = playlist.length;
    return songs;
  }

  const Playlist2({super.key, required this.list_name, required this.playlist});
  @override
  State<Playlist2> createState() => _Playlist2State();
}

class _Playlist2State extends State<Playlist2> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        itemCount: widget.playlist.length,
        itemBuilder: (context, index) => Container(
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.white, width: 2))),
            child: ListTile(
              leading: Image.asset(
                "assets/icon/album.png",
                height: 40,
                width: 40,
                color: Color.fromARGB(255, 218, 152, 53),
              ),
              title: Text(
                widget.playlist[index].name,
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.list_name,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              trailing: Image.asset(
                "assets/icon/notliked.png",
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            )));
  }
}
