import 'package:audioplayers/audioplayers.dart';
import 'package:cs486/SettingPage.dart';
import 'package:cs486/Song.dart';
import 'package:flutter/material.dart';

class AddedTrackPage extends StatefulWidget {
  const AddedTrackPage({super.key});

  @override
  State<AddedTrackPage> createState() => _AddedTrackPageState();
}

class _AddedTrackPageState extends State<AddedTrackPage> {
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
                  list_name: 'Added',
                  playlist: added,
                  audioPlayer: AudioPlayer())),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
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
