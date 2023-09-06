import 'package:cs486/SettingPage.dart';
import 'package:cs486/Song.dart';
import 'package:flutter/material.dart';

class ImportPage extends StatefulWidget {
  const ImportPage({super.key});

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                TextField(
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  controller: _textController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      suffixIconColor: Colors.white,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 212, 184, 184))),
                      border: const OutlineInputBorder(),
                      hintText: 'Paste your .mp3 link here !',
                      hintStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _textController.clear();
                          },
                          icon: const Icon(Icons.clear))),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    added.add(Song(name:'Song ${added.length + 1}',
                        asset:_textController.text, liked:false));
                    _textController.clear();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const AlertDialog(
                          title: Text(
                            'Successfully imported',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          content: Text(
                            'Your song was added to the Added Playlist',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          )),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(156, 38, 68, 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(197, 26, 120, 1),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(4, 4)),
                          BoxShadow(
                              color: Color.fromRGBO(151, 38, 136, 1),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(-4, -4))
                        ]),
                    child: const Center(
                      child: Text(
                        'Import',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 170,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
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
            ),
          )
        ],
      )),
    );
  }
}
