import 'package:darth_flutter/service/adventure_manager.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  String text = "test";

  void setupAdventureManager() async {
    AdventureManager instance = AdventureManager();
    await instance.getAdventure();
    setState(() {
      text = instance.currentParagraph.text;
    });
  }

  @override
  void initState() {
    super.initState();
    setupAdventureManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Ekran przygody',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/player_avatar.png'),
                  radius: 40,
                ),
              ),
              const Text('Witaj w grze!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  )),
              Text(text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
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
                  onPressed: () {},
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
                  },
                  child: Icon(Icons.arrow_circle_left),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FloatingActionButton(
                  heroTag: "s",
                  onPressed: () {
                  },
                  child: Icon(Icons.arrow_circle_down),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FloatingActionButton(
                  heroTag: "w",
                  onPressed: () {
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
