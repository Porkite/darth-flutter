import 'dart:convert';
import 'package:darth_flutter/quiz/quiz-http-client.dart';

import 'model/question.dart';

class QuizService {
  QuizApiHttpClient client = QuizApiHttpClient();

  Future<List<Question>> fetchQuiz() async {
    final response = await client.sendRequest();

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Question.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load quiz');
    }
  }
}

