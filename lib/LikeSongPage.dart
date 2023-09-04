import 'package:cs486/Homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Task.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'Song.dart';

class LikedSongPage extends StatefulWidget {
  const LikedSongPage({super.key});

  @override
  State<LikedSongPage> createState() => _LikedSongPageState();
}

class _LikedSongPageState extends State<LikedSongPage> {
  int index = 0;
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 0);
  final _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    super.initState();
    setAudio();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      position = Duration.zero;
      index++;
      if (index >= study.length) {
        index = 0;
      }
      _audioPlayer.play(AssetSource(study[index].asset));
    });
    startTimer();
  }

  Future<void> setAudio() async {
    _audioPlayer.setSourceAsset(study[index].asset);
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 0));
  }

  void setCountDown() {
    const increaseSecondsBy = 1;
    if (!mounted) {
      return;
    }
    setState(() {
      final seconds = myDuration.inSeconds + increaseSecondsBy;
      myDuration = Duration(seconds: seconds);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
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
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 10,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(54, 11, 52, 0.589),
                  Color.fromRGBO(201, 65, 183, 1),
                  Color.fromRGBO(255, 255, 255, 1)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
              ),
              child: Text(
                'Liked',
                style: GoogleFonts.pacifico(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            //Timer
            Container(
              alignment: Alignment.topCenter,
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: Text(
                '$hours:$minutes:$seconds',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 50),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 13,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            focusNode: FocusNode(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage()));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.list_rounded,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.settings,
                              size: 30,
                            ))
                      ],
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 3.5),
                child: SizedBox(
                  height: 50,
                  child: Slider(
                      inactiveColor: Colors.black12,
                      min: 0,
                      max: duration.inSeconds.toDouble() + 1,
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() async {
                          final position = Duration(seconds: value.toInt());
                          await _audioPlayer.seek(position);
                          await _audioPlayer.resume();
                        });
                      }),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 4,
                  left: 25,
                  right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${position.inHours.toString()}:${position.inMinutes.toString()}:${(position.inSeconds % 60).toString()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                      '${duration.inHours.toString()}:${duration.inMinutes.toString()}:${(duration.inSeconds % 60).toString()}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          if (index < 0) {
                            index = liked.length - 1;
                          } else {
                            index--;
                          }
                        });
                        setAudio();
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(!isPlaying ? Icons.play_arrow : Icons.pause,
                          color: Colors.white),
                      onPressed: () async {
                        if (isPlaying) {
                          await _audioPlayer.pause();
                        } else {
                          await _audioPlayer.resume();
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          if (index >= liked.length - 1) {
                            index = 0;
                          } else {
                            index++;
                          }
                        });
                        setAudio();
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Playlist(
                    list_name: 'Liked Tracks',
                    playlist: liked,
                    audioPlayer: _audioPlayer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListTile extends StatefulWidget {
  late Tasks task;
  MyListTile({super.key, required this.task});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.task.task),
        leading: IconButton(
            icon: Icon(widget.task.like ? Icons.album_outlined : Icons.album),
            onPressed: () {
              setState(() {
                widget.task.like = !widget.task.like;
              });
            }));
  }
}
