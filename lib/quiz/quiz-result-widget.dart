import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final int score;
  final int totalQuestions;

  QuizResult(this.score, this.totalQuestions);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Your score: $score / $totalQuestions',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Powrót do ekranu głównego
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}