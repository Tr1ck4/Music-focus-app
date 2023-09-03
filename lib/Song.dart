import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Song {
  final String name;
  final String asset;
  Song(this.name, this.asset);
}

List<Song> meditation = [
  Song('happy', 'audio/music.mp3'),
  Song('direct', 'audio/direct.mp3')
];

List<Playlist> storage = [
  Playlist(list_name: 'meditation', playlist: meditation)
];

class Playlist extends StatefulWidget {
  final String list_name;
  final List<Song> playlist;

  int numSong() {
    int songs = playlist.length;
    return songs;
  }

  const Playlist({super.key, required this.list_name, required this.playlist});
  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
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
