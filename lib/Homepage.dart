import 'package:cs486/SleepPage.dart';
import 'package:cs486/StudyPage.dart';
import 'package:cs486/WorkoutPage.dart';
import 'package:flutter/material.dart';
import 'MeditationPage.dart';
class CustomModeButton extends StatelessWidget{
  final String mod;
  final String text;
  final Function() onPressed;
  const CustomModeButton({super.key,required this.mod,required this.text,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: MediaQuery.of(context).size.height/10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image:  DecorationImage(
            image: AssetImage(mod),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Text(text,style: const TextStyle(fontSize: 25),),
      ),
    );
  }

}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              padding:const EdgeInsets.fromLTRB(0, 100, 0, 0),
              alignment: Alignment.topCenter,
              child: const Text("Choose a mode",style: TextStyle(fontSize: 40,color: Colors.white)),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomModeButton(mod: "assets/meditationbox.png", text: "Meditation", onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MeditationPage(),));
                  },),
                  const SizedBox(height: 20,),
                  CustomModeButton(mod: "assets/workoutbox.png", text: "Workout", onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutPage(),));
                  },),
                  const SizedBox(height: 20,),
                  CustomModeButton(mod: "assets/studybox.png", text: "Study", onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StudyPage(),));
                  },),
                  const SizedBox(height: 20,),
                  CustomModeButton(mod: "assets/sleepbox.png", text: "Sleep", onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SleepPage(),));
                  },),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.fromLTRB(0, 0, 10,100),
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.settings,size: 50,color: Colors.white,))
            ),

          ],
        )
    );
  }
}