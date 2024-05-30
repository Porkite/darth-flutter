import 'package:flutter/material.dart';
import 'model/question.dart';

class QuizQuestion extends StatelessWidget {
  final Question question;
  final Function(bool) answerQuestion;

  QuizQuestion({required this.question, required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                question.question,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: question.answers.entries
                      .where((entry) => entry.value != null)
                      .map((entry) {
                    return SizedBox(
                      width: (constraints.maxWidth / 2) - 20,
                      child: ElevatedButton(
                        onPressed: () {
                          bool isCorrect = question.correctAnswers['${entry.key}_correct'] == true;
                          answerQuestion(isCorrect);
                        },
                        child: Text(entry.value!),
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
