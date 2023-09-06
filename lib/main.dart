import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Song.dart';
import 'database.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  meditation = await DBProvider().readPlaylist("Meditation");
  sleep = await DBProvider().readPlaylist("Sleep");
  study = await DBProvider().readPlaylist("Study");
  workout = await DBProvider().readPlaylist("Workout");
  liked = await DBProvider().readLiked();
  added = await DBProvider().readPlaylist("Added");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
