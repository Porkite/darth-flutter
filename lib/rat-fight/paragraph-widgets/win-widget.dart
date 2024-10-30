import 'package:flutter/material.dart';

import '../paragraph-data.dart';

class WinWidget extends StatelessWidget {
  final ParagraphData paragraphData;

  const WinWidget({Key? key, required this.paragraphData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          Text(paragraphData.winText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
