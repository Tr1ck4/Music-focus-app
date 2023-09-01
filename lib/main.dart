import 'package:cs486/SettingPage.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'MeditationPage.dart';
import 'SettingPage.dart';

void main() {
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
      home: const SettingPage(),
    );
  }
}
