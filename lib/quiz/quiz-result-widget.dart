import 'package:darth_flutter/quiz/model/quiz.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final int score;
  final Quiz _quiz;

  const QuizResult(this.score, Quiz quiz) : _quiz = quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_quiz.winBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  _quiz.winText,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    shadows: [
                      Shadow(
                        blurRadius: 40.0,
                        color: Colors.blueAccent,
                        offset: Offset(10.0, 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  "$score ${_quiz.winItems}",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.amber,
                    shadows: [
                      Shadow(
                        blurRadius: 40.0,
                        color: Colors.blueAccent,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(_quiz.winTextButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
