import 'package:darth_flutter/quiz/model/quiz.dart';
import 'package:flutter/material.dart';
import '../player/player.dart';
import '../service/game_manager.dart';

class QuizFailed extends StatelessWidget {
  final Quiz _quiz;

  const QuizFailed(quiz, {super.key}) : _quiz = quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_quiz.failBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _quiz.failText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => restartQuiz(context),
                child: Text(_quiz.failButtonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void restartQuiz(BuildContext context) {
    Player().addHp(-_quiz.failHpLose);
    Navigator.of(context).pop();
    GameManager().rollbackPlayerPosition(10);
  }
}
