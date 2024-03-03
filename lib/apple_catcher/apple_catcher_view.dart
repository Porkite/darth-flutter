import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class AppleCatcher extends StatefulWidget {
  @override
  AppleCatcherState createState() => AppleCatcherState();
}

class AppleCatcherState extends State<AppleCatcher> {
  double playerPositionX = 150.0;
  double playerPositionY = 0.0;

  double screenWidth = 0;
  List<Apple> apples = [];
  final Random random = Random();
  Timer? appleFallTimer;
  Timer? appleAddTimer;
  Duration appleAddDuration = Duration(milliseconds: 2500);
  Duration appleFallDuration = Duration(milliseconds: 50);

  int score = 0;

  @override
  void initState() {
    super.initState();

    appleFallTimer = Timer.periodic(appleFallDuration, (timer) {
      moveApplesDown();
      checkCollision();
    });


    appleAddTimer = Timer.periodic(appleAddDuration, (timer) {
      final appleX = random.nextDouble() * screenWidth;
      setState(() {
        apples.add(Apple(x: appleX, y: 0));
      });
    });
  }

  @override
  void dispose() {
    appleFallTimer?.cancel();
    super.dispose();
  }

  void moveLeft() {
    setState(() {
      playerPositionX = max(0, playerPositionX - 10);
    });
  }

  void moveRight() {
    setState(() {
      playerPositionX = min(screenWidth - 100, playerPositionX + 10);
    });
  }


  void moveApplesDown() {
    setState(() {
      apples =
          apples.map((apple) => Apple(x: apple.x, y: apple.y + 5)).toList();
    });
  }

  void checkCollision() {
    final playerPositionY = MediaQuery
        .of(context)
        .size
        .height - 50 - 100;
    final catcherLeftX = playerPositionX;
    final catcherRightX = playerPositionX + 100;

    for (var apple in List.from(apples)) {
      final appleBottomY = apple.y + 20;

      if (appleBottomY >= playerPositionY && apple.x >= catcherLeftX &&
          apple.x <= catcherRightX) {
        setState(() {
          score += 1;
          apples.remove(apple);
          if (score % 5 == 0) {
            appleAddDuration = Duration(milliseconds: max(10, appleAddDuration.inMilliseconds - 100));
            appleAddTimer?.cancel(); 
            appleAddTimer = Timer.periodic(appleAddDuration, (timer) {
              final appleX = random.nextDouble() * screenWidth;
              setState(() {
                apples.add(Apple(x: appleX, y: 0));
              });
            });
          }
          if (score % 5 == 0) {
            appleFallDuration = Duration(milliseconds: max(1, appleFallDuration.inMilliseconds - 1));
            appleFallTimer?.cancel();
            appleFallTimer = Timer.periodic(appleFallDuration, (timer) {
              setState(() {
                moveApplesDown();
                checkCollision();
              });
            });
          }




        });
        break;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    playerPositionY = MediaQuery
        .of(context)
        .size
        .height - 50;

    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              playerPositionX =
                  max(50, min(details.localPosition.dx, screenWidth - 50)) - 50;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/apple_tree.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Card(
                      color: Colors.white.withOpacity(0.85),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Score: $score',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                for (var apple in apples)
                  Positioned(
                    left: apple.x,
                    top: apple.y,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 50,
                  left: playerPositionX,
                  child:  Image.asset(
                    'images/apple_rat.png',
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Apple {
  final double x;
  final double y;

  Apple({required this.x, required this.y});
}
