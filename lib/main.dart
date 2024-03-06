import 'package:darth_flutter/game/game.dart';
import 'package:darth_flutter/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/game': (context) => Game(),
      }
  ));
}
