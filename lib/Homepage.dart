import 'package:cs486/database.dart';

import 'SettingPage.dart';
import 'package:flutter/material.dart';
import 'MeditationPage.dart';
import 'SleepPage.dart';
import 'Song.dart';
import 'StudyPage.dart';
import 'WorkoutPage.dart';

class CustomModeButton extends StatelessWidget {
  final String mod;
  final String text;
  final Function() onPressed;
  const CustomModeButton(
      {super.key,
      required this.mod,
      required this.text,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(mod),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Song>meditation=[];
  List<Song>study=[];
  List<Song>sleep=[];
  List<Song>workout=[];
  List<Song>liked=[];
  List<Song>added=[];
  MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Homepage.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          alignment: Alignment.topCenter,
          child: const Text("Choose a mode",
              style: TextStyle(fontSize: 40, color: Colors.white)),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomModeButton(mod: "assets/meditationbox.png", text: "Meditation", onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MeditationPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),));
              },),
              const SizedBox(height: 20,),
              CustomModeButton(mod: "assets/workoutbox.png", text: "Workout", onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),));
              },),
              const SizedBox(height: 20,),
              CustomModeButton(mod: "assets/studybox.png", text: "Study", onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudyPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),));
              },),
              const SizedBox(height: 20,),
              CustomModeButton(mod: "assets/sleepbox.png", text: "Sleep", onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SleepPage(meditation: widget.meditation,workout: widget.workout,study: widget.study,sleep: widget.sleep,added: widget.added,liked: widget.liked),));
              },),
            ],
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 100),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingPage(),
                      ));
                },
                icon: const Icon(
                  Icons.settings,
                  size: 50,
                  color: Colors.white,
                ))),
      ],
    ));
  }
}
