import '../service/model/adventure_models.dart';

class Quiz {
  final String welcomeText;
  final String npcImg;

  Quiz(this.welcomeText, this.npcImg);



  factory Quiz.fromParagraph(Paragraph paragraph) {
    final quizData = paragraph.options;
    final welcomeText = quizData['welcomeText'];
    final npcImg = quizData['NpcImg'];


    return Quiz(welcomeText, npcImg);
  }
}
