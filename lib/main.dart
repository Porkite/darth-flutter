import 'package:darth_flutter/game/game.dart';
import 'package:darth_flutter/home/home.dart';
import 'package:darth_flutter/player/player.dart';
import 'package:darth_flutter/service/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Player()),
        ChangeNotifierProvider(create: (context) => GameManager()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/home',
          routes: {
            '/home': (context) => Home(),
            '/game': (context) => Game(),
          }
      )
    ),
  );
}
