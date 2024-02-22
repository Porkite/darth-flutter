import 'package:flutter/cupertino.dart';

class Shop extends StatelessWidget {
  final String text;

  Shop({required this.text});

@override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
}
