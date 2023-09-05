<<<<<<< Updated upstream
import 'package:cs486/SettingPage.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'MeditationPage.dart';
import 'SettingPage.dart';

void main() {
=======
import 'Song.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'database.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var data = await DBProvider().readPlaylist("Meditation");
  for(int i =0  ;i  < data.length ; i++){
    print(data[i].name);
  }
>>>>>>> Stashed changes
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
