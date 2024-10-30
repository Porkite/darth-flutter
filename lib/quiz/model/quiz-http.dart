class QuizHttp {
  final String apiUrl;
  final String apiKey;
  final String difficulty;
  final int questionNumb;

  QuizHttp(
      this.apiUrl,
      this.apiKey,
      this.difficulty,
      this.questionNumb);

  factory QuizHttp.fromJson(Map<String, dynamic> json) {
    final apiUrl = json['apiUrl'];
    final apiKey = json['apiKey'];
    final difficulty = json['difficulty'];
    final questionNumb = json['questionNumb'];

    return QuizHttp(
        apiUrl,
        apiKey,
        difficulty,
        questionNumb);
  }

}