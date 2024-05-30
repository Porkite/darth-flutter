import 'package:darth_flutter/quiz/quiz-game.dart';
import 'package:flutter/material.dart';

class QuizFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Failed"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You Lost!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => restartQuiz(context),
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void restartQuiz(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => QuizGame()),
    );
  }
}
