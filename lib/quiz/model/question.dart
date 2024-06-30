class Question {
  final int id;
  final String question;
  final String? description;
  final Map<String, String?> answers;
  final bool multipleCorrectAnswers;
  final Map<String, bool> correctAnswers;
  final String? explanation;
  final String? tip;
  final List<dynamic> tags;
  final String category;
  final String difficulty;

  Question({
    required this.id,
    required this.question,
    this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    this.explanation,
    this.tip,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      description: json['description'],
      answers: Map<String, String?>.from(json['answers']),
      multipleCorrectAnswers: json['multiple_correct_answers'] == 'true',
      correctAnswers: Map<String, bool>.from(json['correct_answers'].map(
            (key, value) => MapEntry(key, value == 'true'),
      )),
      explanation: json['explanation'],
      tip: json['tip'],
      tags: List<dynamic>.from(json['tags']),
      category: json['category'],
      difficulty: json['difficulty'],
    );
  }
}
