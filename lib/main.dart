import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 double birdYAxis = 0;
 double time = 0;
 double height = 0;
 double initialHeight = 0;
 int score = 0;
 int bestScore = 0;
 bool gameStarted = false;

 static double birdXAxisOne = 0;
 double birdXAxisTwo = birdXAxisOne + 4;
 double birdXAxisThree = birdXAxisOne + 8;
 int speed = 150;

 @override
  void initState() {
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp,
     DeviceOrientation.portraitDown,
   ]);
    super.initState();
  }


  void jump() {
    setState(() {
      time = 0;
      if(score > bestScore) {
        bestScore = score;
      }
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameStarted = true;
    score = 0;
    Timer.periodic(Duration(milliseconds: speed),(timer) {
      setState(() {
        time += 0.04;
        height = -4.9 * time * time + 2.8 * time;
        birdYAxis = initialHeight - height;
        if(birdXAxisOne < -1.1) {
          birdXAxisOne += 2+12;
        } else {
          birdXAxisOne -= 0.5;
        }

        if(birdXAxisTwo < -1.1) {
          birdXAxisTwo += 2+12;
        } else {
          birdXAxisTwo -= 0.5;
        }

        if(birdXAxisThree < -1.1) {
          birdXAxisThree += 2+12;
        } else {
          birdXAxisThree -= 0.5;
        }

        if(birdXAxisOne == 0 ) {
          speed --;
          if(birdYAxis > 0.25 || birdYAxis < -0.25) {
                 setCancel(timer);
          } else {
            score += 5;
          }
        }

        if(birdXAxisTwo == 0 ) {
          speed --;
          if(birdYAxis > 0.1 || birdYAxis < -0.4) {
               setCancel(timer);
          }else {
            score += 5;
          }
        }

        if(birdXAxisThree == 0 ) {
          speed --;
          if(birdYAxis > 0.35 || birdYAxis < -0.15) {
               setCancel(timer);
          }else {
            score += 5;
          }
        }
        if(birdYAxis >= 1  || birdYAxis <= -1.1) {
          setCancel(timer);
        }
      });
    });
  }

  void setCancel(Timer timer) {
    birdYAxis = 0;
    time = 0;
    initialHeight = 0;
    timer.cancel();
    showDialog_(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  if(gameStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0,birdYAxis),
                      duration: const Duration(milliseconds: 60),
                      color: Colors.blue,
                      child: const SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                            image: AssetImage("assests/floppy_bird.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    AnimatedContainer(
                        alignment: Alignment(birdXAxisOne,1.1),
                        duration: const Duration(milliseconds: 60),
                        child: Container(
                          height: 200,
                          width: 100,
                          decoration: boxDecoration(),
                        ),
                     ),
                    AnimatedContainer(
                        alignment: Alignment(birdXAxisOne,-1.1),
                        duration: const Duration(milliseconds: 60),
                        child: Container(
                          height: 200,
                          width: 100,
                          decoration: boxDecoration(),
                        ),
                     ),
                    AnimatedContainer(
                        alignment: Alignment(birdXAxisTwo,1.1),
                        duration: const Duration(milliseconds: 60),
                        child: Container(
                          height: 250,
                          width: 100,
                          decoration: boxDecoration(),
                        ),
                     ),
                    AnimatedContainer(
                        alignment: Alignment(birdXAxisTwo,-1.1),
                        duration: const Duration(milliseconds: 60),
                        child: Container(
                          height: 150,
                          width: 100,
                          decoration: boxDecoration(),
                        ),
                     ),
                    AnimatedContainer(
                        alignment: Alignment(birdXAxisThree,1.1),
                        duration: const Duration(milliseconds: 60),
                        child: Container(
                          height: 180,
                          width: 100,
                          decoration: boxDecoration(),
                        ),
                     ),

                    AnimatedContainer(
                        alignment: Alignment(birdXAxisThree,-1.1),
                        duration: const Duration(milliseconds: 60),
                        child: Container(
                          height: 220,
                          width: 100,
                          decoration: boxDecoration(),
                        ),
                     ),
                    Container(
                      alignment: const Alignment(0,-0.2),
                      child: setTextWithColor(gameStarted ? " " : "T A B  T O  P L A Y", Colors.black),
                    ),
                  ],
                ),
              ),
              ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          setText("Score"),
                          const SizedBox(
                            height: 20,
                          ),
                          setText("$score"),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          setText("Best"),
                          const SizedBox(
                            height: 20,
                          ),
                          setText("$bestScore"),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
      )
        ),
    );

  }

  Widget setText(String text) {
    return  Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),);
  }

 showDialog_(BuildContext context) {
     return showDialog<void>(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context) {
         return AlertDialog(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10),
           ),
           backgroundColor: Colors.black26,
           title: setText("Alert"),
           content: SizedBox(
             height: 150,
             child: Column(
               children: [
                 setTextWithColor("your Score $score", Colors.white),
                 Padding(
                   child:setTextWithColor("Please try again",Colors.white),
                     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                 ),
                 Container(
                   margin: const EdgeInsets.symmetric(vertical: 15),
                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                   width: 100,
                   child: TextButton(
                       onPressed: () {
                         setState(() {
                           birdXAxisOne = 0;
                           birdXAxisTwo = birdXAxisOne + 4;
                           birdXAxisThree = birdXAxisOne + 8;
                           score = 0;
                           birdYAxis = 0;
                           gameStarted = false;
                         });
                         Navigator.pop(context);
                       }, child: setTextWithColor("Ok",Colors.black)),
                 )
               ],
             ),
           ),
         );
       },
     );
 }


  BoxDecoration boxDecoration() {
    return BoxDecoration(
        color: Colors.greenAccent,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.green,width: 10));
  }

  setTextWithColor(String text, Color color) {
    return  Text(text, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold));
  }
}
