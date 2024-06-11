import 'package:darth_flutter/quiz/quiz-result-widget.dart';
import 'package:darth_flutter/quiz/model/quiz.dart';
import 'package:flutter/material.dart';
import '../player/player.dart';
import 'quiz-question-widget.dart';
import 'util/quiz-fetch-util.dart';
import 'model/question.dart';
import 'quiz-failed-widget.dart';

class QuizGame extends StatefulWidget {
  final Quiz _quiz;

  const QuizGame({Key? key, required Quiz quiz})
      : _quiz = quiz,
        super(key: key);

  @override
  State<QuizGame> createState() => QuizGameState();
}

class QuizGameState extends State<QuizGame> {
  late Future<List<Question>> _quizFuture;

  List<Question> questions = List.empty();
  String mainText = "";
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool? lastAnswerCorrect;
  final List<bool> _answeredCorrectly = [];

  @override
  void initState() {
    super.initState();
    mainText = widget._quiz.firstQuestionText;
    _quizFuture = QuizFetchUtil.fetchQuiz(widget._quiz.quizHttp);
  }

  void _answerQuestion(bool isCorrect) {
    lastAnswerCorrect = isCorrect;
    if (isCorrect) {
      setState(() {
        mainText = widget._quiz.correctAnswerText;
        _answeredCorrectly.add(true);
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _score += 250;
          _currentQuestionIndex++;
          this.mainText = widget._quiz.nextQuestionText;
        });
      });

      if (_currentQuestionIndex == questions.length - 1) {
        Player().addCoins(_score);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResult(_score, widget._quiz),
          ),
        );
      }
    } else {
      setState(() {
        this.mainText = widget._quiz.failAnswer;
        _answeredCorrectly.add(false);
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuizFailed(widget._quiz),
            ),
          );
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
            image: AssetImage(widget._quiz.quizBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Question>>(
          future: _quizFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              questions = snapshot.data!;
              return Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10),
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
                                  style: const TextStyle(fontSize: 12),
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
                            debug: widget._quiz.debug),
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
