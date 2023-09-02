import 'package:cs486/Homepage.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/user.png",
                    height: 50,
                    width: 50,
                    color: Colors.deepPurpleAccent.shade200,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 200,
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
                            'Username',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     Container(
                  //         height: 50,
                  //         width: 200,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: Colors.white.withOpacity(0.3))),
                  //     Text(
                  //       'Username',
                  //       style: TextStyle(
                  //           fontSize: 24,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.redAccent),
                  //     ),
                  //   ],
                  // )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/tracks.png",
                    height: 50,
                    width: 50,
                    color: Colors.amberAccent.shade400,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 200,
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
                            'Liked Tracks',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/recent.png",
                    height: 50,
                    width: 50,
                    color: Colors.cyanAccent.shade700,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 200,
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
                            'Recent',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icon/download.png",
                    height: 50,
                    width: 50,
                    color: Colors.greenAccent.shade400,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 200,
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
                            'Import ur song',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/app_ava/ava1.png",
                  height: 130,
                  width: 130,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(),
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 50,
                        color: Colors.white,
                      ))),
            ]),
          )
        ],
      )),
    );
  }
}
