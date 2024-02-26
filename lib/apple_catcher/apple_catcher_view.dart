import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class AppleCatcher extends StatefulWidget {
  @override
  AppleCatcherState createState() => AppleCatcherState();
}

class AppleCatcherState extends State<AppleCatcher> {
  double playerPositionX = 0.0;
  double playerPositionY = 0.0;

  double screenWidth = 0;
  List<Apple> apples = [];
  final Random random = Random();
  Timer? timer;
  int score = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      moveApplesDown();
      checkCollision();
    });


    Timer.periodic(Duration(milliseconds: 500), (timer) {
      final appleX = random.nextDouble() * screenWidth;
      setState(() {
        apples.add(Apple(x: appleX, y: 0));
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
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
      apples = apples.map((apple) => Apple(x: apple.x, y: apple.y + 5)).toList();
    });
  }

  void checkCollision() {
    final playerPositionY = MediaQuery.of(context).size.height - 50 - 100;
    final catcherLeftX = playerPositionX;
    final catcherRightX = playerPositionX + 100;

    for (var apple in List.from(apples)) {
      final appleBottomY = apple.y + 20;

      if (appleBottomY >= playerPositionY && apple.x >= catcherLeftX && apple.x <= catcherRightX) {
        setState(() {
          score += 1;
          apples.remove(apple);
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    playerPositionY = MediaQuery.of(context).size.height - 50;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Score: $score'),
        ),
        body: Stack(
          children: [
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
              child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: moveLeft,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: moveRight,
                  ),
                ],
              ),
            ),
          ],
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
