import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'game-settings.dart';
import 'item.dart';

class ItemCatcherGame extends StatefulWidget {
  final GameSettings _gameSettings;

  const ItemCatcherGame({Key? key, required GameSettings gameSettings})
      : _gameSettings = gameSettings,
        super(key: key);

  @override
  ItemCatcherGameState createState() => ItemCatcherGameState();
}

class ItemCatcherGameState extends State<ItemCatcherGame> {
  double playerPositionX = 150.0;
  double playerPositionY = 0.0;

  double screenWidth = 0;
  double screenHeight = 0;

  List<Item> items = [];
  final Random random = Random();
  Timer? itemFallTimer;
  Timer? itemAddTimer;
  Duration itemAddDuration = const Duration(milliseconds: 1500);
  Duration itemFallDuration = const Duration(milliseconds: 30);

  int score = 0;

  @override
  void initState() {
    super.initState();

    itemFallTimer = Timer.periodic(itemFallDuration, (timer) {
      moveItemsDown();
      checkCollision();
    });

    itemAddTimer = Timer.periodic(itemAddDuration, (timer) {
      final itemX = random.nextDouble() * screenWidth;
      setState(() {
        items.add(Item(x: itemX, y: 0));
      });
    });
  }

  @override
  void dispose() {
    itemFallTimer?.cancel();
    itemAddTimer?.cancel();
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

  void moveItemsDown() {
    setState(() {
      items = items.map((item) => Item(x: item.x, y: item.y + 5)).toList();
    });
  }

  void checkCollision() {
    final playerPositionY = MediaQuery.of(context).size.height - 50 - 100;
    final catcherLeftX = playerPositionX;
    final catcherRightX = playerPositionX + 100;

    for (var item in List.from(items)) {
      final itemBottomY = item.y + 20;

      if (itemBottomY >= playerPositionY &&
          item.x >= catcherLeftX &&
          item.x <= catcherRightX) {
        score += 1;
        if (score >= widget._gameSettings.targetScore) {
          Navigator.pop(context, {'score': score});
        }
        items.remove(item);
        if (score % 5 == 0) {
          incrementLvl();
        }
      }
      if (itemBottomY >= screenHeight - 20) {
        items.remove(item);
        Navigator.pop(context, {'score': score});
      }
    }
  }

  incrementLvl() {
    itemAddDuration =
        Duration(milliseconds: max(200, itemAddDuration.inMilliseconds - 200));
    itemAddTimer?.cancel();
    itemAddTimer = Timer.periodic(itemAddDuration, (timer) {
      final itemX = random.nextDouble() * screenWidth;
      setState(() {
        items.add(Item(x: itemX, y: 0));
      });
    });
    itemFallDuration =
        Duration(milliseconds: max(10, itemFallDuration.inMilliseconds - 2));
    itemFallTimer?.cancel();
    itemFallTimer = Timer.periodic(itemFallDuration, (timer) {
      setState(() {
        moveItemsDown();
        checkCollision();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    playerPositionY = MediaQuery.of(context).size.height - 10;

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
                image: AssetImage(widget._gameSettings.backgroundImg),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Score: $score',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                for (var item in items)
                  Positioned(
                    left: item.x,
                    top: item.y,
                    child: Image.asset(
                      widget._gameSettings.itemImg,
                      width: 20,
                      height: 20,
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  left: playerPositionX,
                  child: Image.asset(
                    widget._gameSettings.playerImg,
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


