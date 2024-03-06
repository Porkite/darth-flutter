import 'package:darth_flutter/game/paragraph-view-factory.dart';
import 'package:darth_flutter/service/model/direction.dart';
import 'package:flutter/material.dart';

import '../service/game_manager.dart';


class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  String selectedIdentifier = 'b2';
  // GameManager().changePlayerPosition('ds');
  // Singleton().doSomething();

  void setSelectedIdentifier(Direction direction) {
    setState(() {
      GameManager().changePlayerPosition(direction);
      selectedIdentifier = GameManager().getPlayerPosition();
    });
  }

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Ekran przygody ($selectedIdentifier)',
            style: const TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<Widget>(
          future: ParagraphViewFactory.buildParagraphViewByIdentifier(selectedIdentifier),
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
                    setSelectedIdentifier(Direction.NORTH);
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
                    setSelectedIdentifier(Direction.EAST);
                  },
                  child: Icon(Icons.arrow_circle_left),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FloatingActionButton(
                  heroTag: "s",
                  onPressed: () {
                    setSelectedIdentifier(Direction.SOUTH);
                  },
                  child: Icon(Icons.arrow_circle_down),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FloatingActionButton(
                  heroTag: "w",
                  onPressed: () {
                    setSelectedIdentifier(Direction.WEST);
                  },
                  child: Icon(Icons.arrow_circle_right),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
