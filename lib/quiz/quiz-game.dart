import 'package:flutter/material.dart';
import 'quiz-question-widget.dart';
import 'quiz-result-widget.dart';
import 'quiz-service.dart';
import 'model/question.dart';
import 'quiz-faild-widget.dart';

class QuizGame extends StatefulWidget {
  @override
  State<QuizGame> createState() => QuizGameState();
}

class QuizGameState extends State<QuizGame> {
  late Future<List<Question>> _quizFuture;
  final QuizService _quizService = QuizService();
  String mainText = "Quiz Game";
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool? lastAnswerCorrect;
  List<bool> _answeredCorrectly = [];

  @override
  void initState() {
    super.initState();
    _quizFuture = _quizService.fetchQuiz();
  }

  void _answerQuestion(bool isCorrect) {
    lastAnswerCorrect = isCorrect;
    if (isCorrect) {
      setState(() {
        this.mainText = "Brawo to jest poprawna odpowiedz";
        _answeredCorrectly.add(true);
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _score++;
          _currentQuestionIndex++;
          this.mainText = "Kolejne pytanie";
        });
      });
    } else {
      setState(() {
        this.mainText = "Zła odpowiedź";
        _answeredCorrectly.add(false);
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizFailed(),
              ),
            );
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quiz-game/quiz-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Question>>(
          future: _quizFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<Question> questions = snapshot.data!;
              return Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(questions.length, (index) {
                          return Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                margin: EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                  color: index < _answeredCorrectly.length
                                      ? _answeredCorrectly[index]
                                      ? Colors.green
                                      : Colors.red
                                      : Colors.grey,
                                  border: Border.all(
                                    color: index == _currentQuestionIndex
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  '${(index + 1) * 250}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          );
                        }).reversed.toList(),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[50],
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              mainText,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      if (_currentQuestionIndex < questions.length)
                        const Spacer(),
                        Expanded(
                          child: QuizQuestion(
                            question: questions[_currentQuestionIndex],
                            answerQuestion: _answerQuestion,
                          ),
                        ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
