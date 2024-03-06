import 'package:darth_flutter/editor/home/home.dart';
import 'package:darth_flutter/editor/welcome/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
      }
  ));
}
