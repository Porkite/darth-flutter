import 'package:flutter/material.dart';
import 'model/question.dart';

class QuizQuestion extends StatefulWidget {
  final Question question;
  final bool debug;
  final Function(bool) answerQuestion;

  QuizQuestion(
      {required this.question,
      required this.answerQuestion,
      required this.debug});

  @override
  QuizQuestionState createState() => QuizQuestionState();
}

class QuizQuestionState extends State<QuizQuestion> {
  String selectedAnswer = "";
  bool isCorrect = false;

  @override
  void didUpdateWidget(covariant QuizQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      setState(() {
        selectedAnswer = "";
        isCorrect = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                widget.question.question,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: widget.question.answers.entries
                      .where((entry) => entry.value != null)
                      .map((entry) {
                    return SizedBox(
                      width: (constraints.maxWidth / 2) - 20,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedAnswer = entry.key;
                          });
                          isCorrect = widget.question
                                  .correctAnswers['${entry.key}_correct'] ==
                              true;
                          widget.answerQuestion(isCorrect);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedAnswer != entry.key
                              ? null
                              : isCorrect
                                  ? Colors.green
                                  : Colors.red,
                        ),
                        child: Text(entry.value! +
                            (widget.debug == true
                                ? (widget.question.correctAnswers[
                                            '${entry.key}_correct'] ==
                                        true
                                    ? " * "
                                    : "")
                                : "")),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
