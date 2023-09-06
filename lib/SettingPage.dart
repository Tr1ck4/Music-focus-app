import 'package:cs486/Homepage.dart';
import 'package:cs486/ImportPage.dart';
import 'package:cs486/LikedTrackPage.dart';
import 'package:cs486/PlaylistPage.dart';
import 'package:cs486/PlaylistSong.dart';
import 'package:cs486/Song.dart';
import 'package:cs486/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  List<Song>meditation = [];
  List<Song>study = [];
  List<Song>workout = [];
  List<Song>sleep = [];
  List<Song>liked = [];
  List<Song>added = [];
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Welcome to Setting Page !',
                style: GoogleFonts.pacifico(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/tracks.png",
                    height: 50,
                    width: 50,
                    color: Colors.amberAccent.shade400,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistSongPage(
                                  list_name: 'Liked Track', name: widget.liked),
                            ));
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(156, 38, 68, 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(197, 26, 120, 1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(4, 4)),
                              BoxShadow(
                                  color: Color.fromRGBO(151, 38, 136, 1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4))
                            ]),
                        child: const Center(
                          child: Text(
                            'Liked Tracks',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/playlist.png",
                    height: 50,
                    width: 50,
                    color: Colors.cyanAccent.shade700,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),
                            ));
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(156, 38, 68, 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(197, 26, 120, 1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(4, 4)),
                              BoxShadow(
                                  color: Color.fromRGBO(151, 38, 136, 1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4))
                            ]),
                        child: const Center(
                          child: Text(
                            'Playlists',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/download.png",
                    height: 50,
                    width: 50,
                    color: Colors.greenAccent.shade400,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImportPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),
                            ));
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(156, 38, 68, 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(197, 26, 120, 1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(4, 4)),
                              BoxShadow(
                                  color: Color.fromRGBO(151, 38, 136, 1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(-4, -4))
                            ]),
                        child: const Center(
                          child: Text(
                            'Import ur song',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/app_ava/ava1.png",
                  height: 130,
                  width: 130,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 50,
                        color: Colors.white,
                      ))),
            ]),
          )
        ],
      )),
    );
  }
}
