import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionSucces extends StatelessWidget {
  final VoidCallback restartQuiz;

  QuestionSucces({required this.restartQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Question Correct',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: restartQuiz,
            child: Text('Retry xd'),
          ),
        ],
      ),
    );
  }
}