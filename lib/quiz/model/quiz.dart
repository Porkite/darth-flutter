import 'package:darth_flutter/quiz/model/quiz-http.dart';

import '../../service/model/adventure_models.dart';

class Quiz {
  final String welcomeText;
  final String quizBackground;
  final String npcImg;
  final String playButtonText;
  final String returnButtonText;
  final String firstQuestionText;
  final String nextQuestionText;
  final String correctAnswerText;
  final String failAnswer;
  final String failBackground;
  final String failText;
  final String failButtonText;
  final int failHpLose;
  final String winBackground;
  final String winText;
  final String winTextButton;
  final String winItems;
  final bool debug;
  final QuizHttp quizHttp;

  Quiz(
      this.welcomeText,
      this.quizBackground,
      this.npcImg,
      this.playButtonText,
      this.returnButtonText,
      this.firstQuestionText,
      this.correctAnswerText,
      this.failAnswer,
      this.nextQuestionText,
      this.failBackground,
      this.failText,
      this.failButtonText,
      this.failHpLose,
      this.winBackground,
      this.winText,
      this.winTextButton,
      this.winItems,
      this.debug,
      this.quizHttp);

  factory Quiz.fromParagraph(Paragraph paragraph) {
    final quizData = paragraph.options;
    final welcomeText = quizData['welcomeText'];
    final quizBackground = quizData['quizBackground'];
    final npcImg = quizData['npcImg'];
    final playButtonText = quizData['playButtonText'];
    final returnButtonText = quizData['returnButtonText'];
    final firstQuestionText = quizData['firstQuestionText'];
    final nextQuestionText = quizData['nextQuestionText'];
    final correctAnswerText = quizData['correctAnswerText'];
    final failAnswer = quizData['failAnswer'];
    final failBackground = quizData['failBackground'];
    final failText = quizData['failText'];
    final failButtonText = quizData['failButtonText'];
    final failHpLose = quizData['failHpLose'];
    final winBackground = quizData['winBackground'];
    final winText = quizData['winText'];
    final winTextButton = quizData['winTextButton'];
    final winItems = quizData['winItems'];
    final debug = quizData['debug'];
    final gameSettings = QuizHttp.fromJson(quizData['quizHttp']);

    return Quiz(
        welcomeText,
        quizBackground,
        npcImg,
        playButtonText,
        returnButtonText,
        firstQuestionText,
        correctAnswerText,
        failAnswer,
        nextQuestionText,
        failBackground,
        failText,
        failButtonText,
        failHpLose,
        winBackground,
        winText,
        winTextButton,
        winItems,
        debug,
        gameSettings);
  }
}
