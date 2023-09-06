import 'package:audioplayers/audioplayers.dart';
import 'PlaylistSong.dart';
import 'database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Song {
  late String name = '';
  late String asset='';
  late bool liked = false;
  Song({required this.name, required this.asset, required this.liked});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'asset': asset,
      'liked': liked?1:0,
    };
  }
}
class MyIconButton extends StatefulWidget {
  late Song song;
  late String playlist;
  late List<Song> liked;
  MyIconButton({super.key,required this.song,required this.playlist,required this.liked});
  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  void update()async{
    await DBProvider().updateSong(widget.song);
    widget.liked = await DBProvider().readLiked();
    print(widget.liked);
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState((){
          if(widget.playlist !='Added Tracks'){
            widget.song.liked = !widget.song.liked;
            update();
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
  List<Song> liked = [];
  final AudioPlayer audioPlayer;
  final String list_name;
  late List<Song> playlist;
  Playlist(
      {super.key,
      required this.list_name,
      required this.playlist,
      required this.audioPlayer,
        required this.liked
      });
  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  late String _path;
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
                trailing: MyIconButton(playlist: widget.list_name,song: widget.playlist[index],liked: widget.liked),
                onTap: ()  {
                  setState(() async{
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
  late AudioPlayer audioPlayer;
  List<Song>meditation = [];
  List<Song>study = [];
  List<Song>workout = [];
  List<Song>sleep = [];
  List<Song>liked = [];
  List<Song>added = [];
  List<Playlist> album;
  final String album_name;
  Album({
    super.key,
    required this.album,
    required this.album_name,
    required this.meditation,required this.study,required this.workout, required this.sleep, required this.added,required this.liked,
    required this.audioPlayer
  });
  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 30),
        children: [
          ListTile(
            leading: Image.asset(
              "assets/icon/playlist.png",
              height: 70,
              width: 70,
              color: Colors.cyanAccent.shade700,
            ),
            title: Text(
              "Meditation",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '${widget.meditation.length.toString()} tracks',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistSongPage(
                        list_name: "Meditation",
                        name: widget.meditation,audioPlayer: widget.audioPlayer,)));
            },
          ),
          const SizedBox(height: 40,),
          ListTile(
            leading: Image.asset(
              "assets/icon/playlist.png",
              height: 70,
              width: 70,
              color: Colors.cyanAccent.shade700,
            ),
            title: Text(
              "Study",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '${widget.study.length.toString()} tracks',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistSongPage(
                        list_name: "Study",
                        name: widget.study,audioPlayer: widget.audioPlayer,)));
            },
          ),
          const SizedBox(height: 40,),
          ListTile(
            leading: Image.asset(
              "assets/icon/playlist.png",
              height: 70,
              width: 70,
              color: Colors.cyanAccent.shade700,
            ),
            title: Text(
              "Workout",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '${widget.workout.length.toString()} tracks',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistSongPage(
                        list_name: "Workout",
                        name: widget.workout,audioPlayer: widget.audioPlayer,)));
            },
          ),
          const SizedBox(height: 40,),
          ListTile(
            leading: Image.asset(
              "assets/icon/playlist.png",
              height: 70,
              width: 70,
              color: Colors.cyanAccent.shade700,
            ),
            title: Text(
              "Sleep",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '${widget.sleep.length.toString()} tracks',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistSongPage(
                        list_name: "Sleep",
                        name: widget.sleep,audioPlayer: widget.audioPlayer,)));
            },
          ),
          const SizedBox(height: 40,),
          ListTile(
            leading: Image.asset(
              "assets/icon/playlist.png",
              height: 70,
              width: 70,
              color: Colors.cyanAccent.shade700,
            ),
            title: Text(
              "Favourite",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '${widget.liked.length.toString()} tracks',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistSongPage(
                        list_name: "Favourite",
                        name: widget.liked,audioPlayer: widget.audioPlayer)));
            },
          ),
          const SizedBox(height: 40,),
          ListTile(
            leading: Image.asset(
              "assets/icon/playlist.png",
              height: 70,
              width: 70,
              color: Colors.cyanAccent.shade700,
            ),
            title: Text(
              "Added ",
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '${widget.added.length.toString()} tracks',
              style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaylistSongPage(
                        list_name: "Added tracks",
                        name: widget.added,audioPlayer: widget.audioPlayer,)));
            },
          )
        ],

    );
  }
}


