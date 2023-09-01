import 'package:flutter/material.dart';

class Song{
  final String name;
  final String asset;
  Song(this.name, this.asset);
}
List<Song> meditation =  [Song('happy','audio/music.mp3'),Song('direct', 'audio/direct.mp3')];
class Playlist extends StatefulWidget{
  final String list_name;
  final List<Song> playlist ;
  const Playlist({super.key, required this.list_name, required this.playlist});
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
                title: Text(widget.playlist[index].name)
            )
          )
    );
  }

}
