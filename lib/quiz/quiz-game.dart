import 'package:darth_flutter/quiz/quiz-faild-widget.dart';
import 'package:flutter/material.dart';
import 'quiz-question-widget.dart';
import 'quiz-result-widget.dart';
import 'quiz-service.dart';
import 'model/question.dart';

class QuizGame extends StatefulWidget {
  @override
  State<QuizGame> createState() => QuizGameState();
}

class QuizGameState extends State<QuizGame> {
  late Future<List<Question>> _quizFuture;
  final QuizService _quizService = QuizService();

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool? lastAnswerCorrect;

  @override
  void initState() {
    super.initState();
    _quizFuture = _quizService.fetchQuiz();
  }

  void _answerQuestion(bool isCorrect) {
    setState(() {
      lastAnswerCorrect = isCorrect;
      if (isCorrect) {
        _score++;
        _currentQuestionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizFailed(),
          ),
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Game'),
      ),
      body: FutureBuilder<List<Question>>(
        future: _quizFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Question> questions = snapshot.data!;
            return Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Quiz Game',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                Expanded(
                  child: _currentQuestionIndex < questions.length
                      ? QuizQuestion(
                    question: questions[_currentQuestionIndex],
                    answerQuestion: _answerQuestion,
                  )
                      : QuizResult(_score, questions.length),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
