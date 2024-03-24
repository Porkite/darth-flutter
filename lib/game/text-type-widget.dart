import 'package:flutter/material.dart';

class TextTypeWidget extends StatelessWidget {
  final String text;

  TextTypeWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Center(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/player_avatar.png'),
            radius: 40,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Witaj w grze!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
