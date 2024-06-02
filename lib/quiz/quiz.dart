import '../service/model/adventure_models.dart';

class Quiz {
  final String welcomeText;
  final String npcImg;
  final String playButtonText;
  final String returnButtonText;


  Quiz(this.welcomeText, this.npcImg, this.playButtonText, this.returnButtonText);



  factory Quiz.fromParagraph(Paragraph paragraph) {
    final quizData = paragraph.options;
    final welcomeText = quizData['welcomeText'];
    final playButtonText = quizData['playButtonText'];
    final returnButtonText = quizData['returnButtonText'];

    final npcImg = quizData['npcImg'];


    return Quiz(welcomeText, npcImg, playButtonText, returnButtonText);
  }
}
