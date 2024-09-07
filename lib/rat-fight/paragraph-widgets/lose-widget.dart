import 'package:flutter/material.dart';
import 'package:darth_flutter/service/game_manager.dart';

import '../paragraph-data.dart';

class LoseWidget extends StatelessWidget {
  final ParagraphData paragraphData;

  const LoseWidget({Key? key, required this.paragraphData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          Text(
            "I co!? Trzeba było się rzucać?. Teraz tracisz wszystkie talarki.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                GameManager().rollbackPlayerPosition(1);
              },
              child: Text('Jeszcze tu wróce'))
        ],
      ),
    );
  }
}