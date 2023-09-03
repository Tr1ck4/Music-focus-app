import 'Task.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'Song.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});
  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int index = 0;
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 0);
  final  _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    super.initState();
    setAudio();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state== PlayerState.playing;
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
      if (index >= meditation.length) {
        index = 0;
      }
      _audioPlayer.play(AssetSource(meditation[index].asset));
    });
    startTimer();
  }
  Future<void> setAudio() async{
    _audioPlayer.setSourceAsset(meditation[index].asset);
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
    setState(() => myDuration = const  Duration(seconds: 0));
  }

  void setCountDown() {
    const increaseSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds + increaseSecondsBy;
      myDuration = Duration(seconds: seconds);
    });
  }

  @override
  void dispose(){
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
                  image: AssetImage("assets/Meditationpage.png"),
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
                  Color.fromRGBO(45, 153, 230, 1),
                  Color.fromRGBO(101, 190, 255, 1),
                  Color.fromRGBO(126, 235, 222, 1)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
              ),
              child: const Text(
                'Meditation',
                style: TextStyle(color: Colors.white, fontSize: 30),
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
                  height: MediaQuery.of(context).size.height/13,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(focusNode: FocusNode(),onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,size: 30,)),
                      IconButton(onPressed: (){
                        showModalBottomSheet(
                          context: context, builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(45, 153, 230, 1),
                                    Color.fromRGBO(101, 190, 255, 1),
                                    Color.fromRGBO(126, 235, 222, 1)
                                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                ),
                                height: 200,
                                child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    itemCount: meditation_Task.length,
                                    itemBuilder: (context, index) => Container(
                                        decoration: const BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Colors.white,width: 2))
                                        ),
                                        child:ListTile(
                                          title: Text(meditation_Task[index].task),
                                          leading: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                meditation_Task[index].like = !meditation_Task[index].like;
                                                print(meditation_Task[index].like?1:0);
                                              });
                                            },
                                            icon: meditation_Task[index].like?const Icon(Icons.album_outlined):const Icon(Icons.album),
                                          )
                                        )
                                    )
                                )
                              );
                          },
                        );
                      }, icon: const Icon(Icons.list_rounded,size: 30,)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.settings,size: 30,))
                    ],
                  ),
                )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/3.5),
                child: SizedBox(
                  height: 50,
                  child: Slider(
                    inactiveColor: Colors.black12,
                    min: 0,
                    max: duration.inSeconds.toDouble()+1,
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() async {
                        final position = Duration(seconds:value.toInt());
                        await _audioPlayer.seek(position);
                        await _audioPlayer.resume();
                      });
                    }
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/4,left: 25,right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${position.inHours.toString()}:${position.inMinutes.toString()}:${(position.inSeconds%60).toString()}',style: const TextStyle(color: Colors.white),),
                  Text('${duration.inHours.toString()}:${duration.inMinutes.toString()}:${(duration.inSeconds%60).toString()}',style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height/5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        if(index <0)
                        {index=meditation.length-1;}else{
                          index--;
                        }
                      });
                      setAudio();
                    },
                    icon: const Icon(Icons.skip_previous,color: Colors.white,),
                  ),
                  IconButton(
                    icon: Icon(!isPlaying?Icons.play_arrow:Icons.pause,color: Colors.white),
                    onPressed: () async {
                      if(isPlaying){
                        await _audioPlayer.pause();
                      }else{
                        await _audioPlayer.resume();
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        if(index >= meditation.length-1)
                        {index=0;}else{
                          index++;
                        }
                      });
                      setAudio();
                    },
                      icon: const Icon(Icons.skip_next,color: Colors.white,),
                  )
                ],
              )
            ),
            Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/4,
                  child: Playlist(list_name: 'Meditation', playlist: meditation,audioPlayer: _audioPlayer),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
