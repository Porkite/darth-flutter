import '../service/game_manager.dart';
import '../service/model/adventure_models.dart';

import 'package:darth_flutter/quiz/quiz-game.dart';
import 'package:darth_flutter/quiz/model/quiz.dart';
import 'package:flutter/material.dart';

class QuizViewWidget extends StatefulWidget {
  final Paragraph paragraph;

  const QuizViewWidget({super.key, required this.paragraph});

  @override
  QuizViewWidgetState createState() => QuizViewWidgetState();
}

class QuizViewWidgetState extends State<QuizViewWidget> {
  late Quiz _quiz;

  @override
  void initState() {
    super.initState();
    _quiz = Quiz.fromParagraph(widget.paragraph);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: AssetImage(_quiz.npcImg),
            radius: 40,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.paragraph.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          _quiz.welcomeText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizGame(
                        quiz: _quiz,
                      )),
            );
          },
          child: Text(_quiz.playButtonText),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            GameManager().rollbackPlayerPosition(1);
          },
          child: Text(_quiz.returnButtonText),
        ),
      ],
    );
  }
}
