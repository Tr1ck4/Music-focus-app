import 'package:audioplayers/audioplayers.dart';
import 'package:cs486/PlaylistSong.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Song {
  final String name;
  final String asset;
  late bool liked;
  Song(this.name, this.asset, this.liked);
}

List<Song> meditation = [
  Song('Forest sounds', 'audio/Meditation/forest_sounds.mp3', false),
  Song('Waterfall sounds', 'audio/Meditation/waterfall_sounds.mp3', false)
];
List<Song> sleep = [
  Song('Sleeping City', 'audio/Sleep/SleepingCity_JayLounge.mp3', false),
  Song('WYS', 'audio/Sleep/WYS_LoneftEase.mp3', false)
];
List<Song> workout = [
  Song('Conquer', 'audio/Workout/Conquer_Hopex.mp3', false),
  Song(
      'IDidThatDiamond_Ortiz', 'audio/Workout/IDidThatDiamond_Ortiz.mp3', false)
];
List<Song> study = [
  Song('Causes_geek', 'audio/Study/Causes_geek.mp3', false),
  Song('VoiceOfTheForest_YasumuxNo',
      'audio/Study/VoiceOfTheForest_YasumuxNo Spirit.mp3', false)
];
List<Song> liked = [];
List<Song> added = [];

class MyIconButton extends StatefulWidget {
  late Song song;
  late String playlist;
  MyIconButton({super.key,required this.song,required this.playlist});
  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          if(widget.playlist !='Added Tracks'){
            widget.song.liked =!widget.song.liked;
            if(widget.song.liked){
              liked.add(Song(
                  widget.song.name,
                  widget.song.asset,
                  widget.song.liked));
            }
            else{
              liked.removeWhere((element) => element.name == widget.song.name);
            }
          }
        });
      },
      icon: widget.song.liked
          ? Image.asset(
        "assets/icon/liked.png",
        height: 20,
        width: 20,
        color: Colors.red,
      )
          : Image.asset(
        "assets/icon/notliked.png",
        height: 20,
        width: 20,
        color: Colors.white,
      ),
    );
  }
}
class Playlist extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final String list_name;
  final List<Song> playlist;
  const Playlist(
      {super.key,
      required this.list_name,
      required this.playlist,
      required this.audioPlayer});
  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  late String _path;
  void _likeOrNot(int index) {
    setState(() {
      if (widget.list_name == 'Added Tracks') {
        return;
      }
      if (widget.playlist[index].liked == false) {
        widget.playlist[index].liked == true;
      } else {
        widget.playlist[index].liked == false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playlist.isEmpty) {
      return Center(
        child: Text(
          'Playlist does not have any song',
          style: GoogleFonts.openSans(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          itemCount: widget.playlist.length,
          itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2))),
              child: ListTile(
                leading: Image.asset(
                  "assets/icon/album.png",
                  height: 40,
                  width: 40,
                  color: const Color.fromARGB(255, 218, 152, 53),
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                trailing: MyIconButton(playlist: widget.list_name,song: widget.playlist[index]),
                onTap: () async {
                  setState(() {
                    if (widget.list_name == 'Added Tracks') {
                      widget.audioPlayer
                          .play(UrlSource(widget.playlist[index].asset));
                    } else {
                      widget.audioPlayer
                          .play(AssetSource(widget.playlist[index].asset));
                    }
                  });
                },
              )));
    }
  }
}

class Album extends StatefulWidget {
  final String album_name;
  final List<Playlist> album;
  const Album({
    super.key,
    required this.album_name,
    required this.album,
  });

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(),
        itemCount: widget.album.length,
        itemBuilder: (context, index) => SizedBox(
            height: 100,
            child: ListTile(
              leading: Image.asset(
                "assets/icon/playlist.png",
                height: 70,
                width: 70,
                color: Colors.cyanAccent.shade700,
              ),
              title: Text(
                widget.album[index].list_name,
                style: GoogleFonts.openSans(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '${widget.album[index].playlist.length.toString()} tracks',
                style: GoogleFonts.openSans(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlaylistSongPage(
                            list_name: widget.album[index].list_name,
                            name: widget.album[index].playlist)));
              },
            )));
  }
}

List<Playlist> album = [
  Playlist(
      list_name: 'Meditation',
      playlist: meditation,
      audioPlayer: AudioPlayer()),
  Playlist(list_name: 'Sleep', playlist: sleep, audioPlayer: AudioPlayer()),
  Playlist(list_name: 'Workout', playlist: workout, audioPlayer: AudioPlayer()),
  Playlist(list_name: 'Study', playlist: study, audioPlayer: AudioPlayer()),
  Playlist(
      list_name: 'Liked Tracks', playlist: liked, audioPlayer: AudioPlayer()),
  Playlist(
      list_name: 'Added Tracks', playlist: added, audioPlayer: AudioPlayer())
];
