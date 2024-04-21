import 'package:darth_flutter/game/paragraph-view-factory.dart';
import 'package:darth_flutter/service/model/direction.dart';
import 'package:flutter/material.dart';
import 'package:darth_flutter/service/model/coordinates.dart';
import 'package:provider/provider.dart';

import '../service/game_manager.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  void setNewPositionByDirection(Direction direction) {
    GameManager().changePlayerPosition(direction);
  }

  void setNewPositionByCoordinates(Coordinates coordinates) {
    GameManager().setPlayerPosition(coordinates);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameManager>.value(
        value: GameManager(),
        child: Consumer<GameManager>(builder: (context, gameManager, child) {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: Text(
                  'Ekran przygody (${GameManager().getPlayerPositionId()})',
                  style: const TextStyle(
                    color: Colors.white,
                  )),
              centerTitle: true,
              backgroundColor: Colors.grey[850],
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: FutureBuilder<Widget>(
                future: ParagraphViewFactory.buildParagraphViewByIdentifier(
                    GameManager().getPlayerPositionId()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Wystąpił błąd: ${snapshot.error}');
                  } else {
                    return snapshot.data ?? Container();
                  }
                },
              ),
            ),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: "n",
                          onPressed: () {
                            GameManager().changePlayerPosition(Direction.NORTH);
                          },
                          child: Icon(Icons.arrow_circle_up),
                        ),
                      ),
                      SizedBox(width: 64),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: "e",
                          onPressed: () {
                            GameManager().changePlayerPosition(Direction.EAST);
                          },
                          child: Icon(Icons.arrow_circle_left),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: "s",
                          onPressed: () {
                            GameManager().changePlayerPosition(Direction.SOUTH);
                          },
                          child: Icon(Icons.arrow_circle_down),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: "w",
                          onPressed: () {
                            GameManager().changePlayerPosition(Direction.WEST);
                          },
                          child: Icon(Icons.arrow_circle_right),
                        ),
                      ),
                    ],
                  ),
                ]),
          );
        }));
  }
}
