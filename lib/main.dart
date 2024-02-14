import 'package:darth_flutter/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
      }
  ));
}
