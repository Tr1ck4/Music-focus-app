import 'package:cs486/Homepage.dart';
import 'package:cs486/SettingPage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Task.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'Song.dart';
import 'database.dart';

class WorkoutPage extends StatefulWidget {
  List<Song>meditation = [];
  List<Song>study = [];
  List<Song>workout = [];
  List<Song>sleep = [];
  List<Song>liked = [];
  List<Song>added = [];
  WorkoutPage({super.key,required this.meditation,required this.study,required this.workout, required this.sleep, required this.added,required this.liked});
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
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
      if (index >= widget.workout.length) {
        index = 0;
      }
      _audioPlayer.play(AssetSource(widget.workout[index].asset));
    });
    startTimer();
  }

  Future<void> setAudio() async {
    _audioPlayer.setSourceAsset(widget.workout[index].asset);
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
                  image: AssetImage("assets/WorkoutPage.png"),
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
                  Color.fromRGBO(228, 61, 56, 1),
                  Color.fromRGBO(243, 122, 51, 1),
                  Color.fromRGBO(231, 213, 129, 1)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
              ),
              child: Text(
                'Workout',
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
                                          MyHomePage()));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(45, 153, 230, 1),
                                              Color.fromRGBO(101, 190, 255, 1),
                                              Color.fromRGBO(126, 235, 222, 1)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                      ),
                                      height: 200,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          itemCount: work_Task.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2))),
                                                  child: MyListTile(
                                                    task: work_Task[index],
                                                  ))));
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.list_rounded,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingPage(),
                      ));
                            },
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
                            index = widget.workout.length - 1;
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
                          if (index >= widget.workout.length - 1) {
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
                    list_name: 'Workout',
                    playlist: widget.workout,
                    audioPlayer: _audioPlayer,liked: widget.liked,),
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
