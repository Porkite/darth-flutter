import 'package:flutter/material.dart';

import '../service/game_manager.dart';
import '../service/model/adventure_models.dart';
import 'game-state.dart';
import 'item-catcher-game.dart';
import 'item-cather.dart';

class ItemCatcherWidget extends StatefulWidget {
  final Paragraph paragraph;

  const ItemCatcherWidget({super.key, required this.paragraph});

  @override
  State<ItemCatcherWidget> createState() => _ItemCatcherView();
}

class _ItemCatcherView extends State<ItemCatcherWidget> {
  late ItemCatcher _itemCatcher;
  late String _mainText;
  late String _text;
  GameState _gameState = GameState.start;
  int _attemptCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GameManager().setBlockMovement(true);
    });
    _itemCatcher = ItemCatcher.fromParagraph(widget.paragraph);
    _text = widget.paragraph.text;
    _mainText = _itemCatcher.welcomeText;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GameManager().setBlockMovement(false);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: AssetImage(_itemCatcher.witchImg),
            radius: 40,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          _mainText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        if (_gameState != GameState.lost && _gameState != GameState.victory)
          ElevatedButton(
            onPressed: () async {
              await startGame();
            },
            child: Text('Wchodzę w to!'),
          ),
        const SizedBox(height: 10),
        if (_gameState != GameState.lost && _gameState != GameState.victory)
          ElevatedButton(
            onPressed: () {
              GameManager().rollbackPlayerPosition(1);
            },
            child: Text('Nie wejdę'),
          ),
        if (_gameState == GameState.lost)
          ElevatedButton(
            onPressed: () {
              GameManager().rollbackPlayerPosition(10);
            },
            child: Text('O nie!!!'),
          ),
        Spacer(),
      ],
    );
  }

  Future<void> startGame() async {
    dynamic result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ItemCatcherGame(gameSettings: _itemCatcher.gameSettings),
      ),
    );
    int score = result['score'] ?? 0;
    _attemptCount += 1;
    if (score >= _itemCatcher.gameSettings.targetScore) {
      _gameState = GameState.victory;
       GameManager().setBlockMovement(false);
    } else {
      if (_attemptCount < _itemCatcher.gameSettings.maxAttempts) {
        _gameState = GameState.inProgress;
      } else {
        _gameState = GameState.lost;
      }
    }
    changeMainText();
  }

  changeMainText() {
    setState(() {
      if (_gameState == GameState.start) {
        _mainText = _itemCatcher.welcomeText;
      } else if (_gameState == GameState.victory) {
        _mainText = _itemCatcher.successText;
      } else if (_gameState == GameState.inProgress) {
        _mainText = _itemCatcher.retryText;
      } else {
        _mainText = _itemCatcher.failText;
      }
    });
  }
}
