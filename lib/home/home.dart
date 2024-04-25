import 'package:flutter/material.dart';

import '../game/controls/logo.dart';
import '../game/style/color-palette.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.midnightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Logo(),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/game');
                  },
                  child: const Text("Rozpocznij grę!")),
            ),
          ],
        ),
      )
    );
  }
}
