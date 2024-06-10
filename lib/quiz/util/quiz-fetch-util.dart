import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../model/question.dart';
import '../model/quiz-http.dart';

class QuizFetchUtil {

  static Future<List<Question>> fetchQuiz(QuizHttp quizHttp) async {

    final uri = getUri(quizHttp);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Question.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  static Uri getUri(QuizHttp quizHttp) {
    final random = Random();
    final randomCategory = quizHttp.categories[random.nextInt(quizHttp.categories.length)];

    return Uri.parse(quizHttp.apiUrl).replace(
      queryParameters: {
        'apiKey': quizHttp.apiKey,
        'limit': quizHttp.questionNumb.toString(),
        'category': randomCategory,
        'difficulty': quizHttp.difficulty,
      },
    );
  }

}
