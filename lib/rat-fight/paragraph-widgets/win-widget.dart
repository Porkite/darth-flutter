import 'package:flutter/material.dart';

import '../paragraph-data.dart';

class WinWidget extends StatelessWidget {
  final ParagraphData paragraphData;

  const WinWidget({Key? key, required this.paragraphData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          Text(
            "Ała!! Już wystarczy. Masz tu papieroski i idź z bogiem.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
