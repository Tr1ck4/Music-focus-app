import 'package:flutter/material.dart';
import 'dart:async';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});
  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage>{
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: 0));
  }
  void setCountDown() {
    const increaseSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds + increaseSecondsBy;
      final hours = myDuration.inHours;
      if (hours > 99) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
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
              height: MediaQuery.of(context).size.height/10,
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
              ),
              child: const Text('Meditation',style: TextStyle(color: Colors.white,fontSize: 30),),
            ),
            //Timer
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
              child:Text(
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
                      IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new,size: 30,)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.list_rounded,size: 30,)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.settings,size: 30,))
                    ],
                  ),
                )
              ),

            )
          ],
        ),
      ),

    );
  }

}
