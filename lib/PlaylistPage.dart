import 'package:cs486/SettingPage.dart';
import 'package:flutter/material.dart';
import 'Song.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
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
              padding: EdgeInsets.all(40),
              child: Album(album_name: 'Default', album: album)),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingPage(),
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
