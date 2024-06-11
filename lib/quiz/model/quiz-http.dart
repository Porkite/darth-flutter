class QuizHttp {
  final String apiUrl;
  final String apiKey;
  final String difficulty;
  final List<String> categories;
  final int questionNumb;

  QuizHttp(
      this.apiUrl,
      this.apiKey,
      this.difficulty,
      this.categories,
      this.questionNumb);

  factory QuizHttp.fromJson(Map<String, dynamic> json) {
    final apiUrl = json['apiUrl'];
    final apiKey = json['apiKey'];
    final difficulty = json['difficulty'];
    final categories = List<String>.from(json['categories']);
    final questionNumb = json['questionNumb'];

    return QuizHttp(
        apiUrl,
        apiKey,
        difficulty,
        categories,
        questionNumb);
  }

}