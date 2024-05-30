import 'package:http/http.dart' as http;

class QuizApiHttpClient {
  final String apiUrl = 'https://quizapi.io/api/v1/questions';
  final String apiKey = 'P0caeBeQukpTAkc15r6aEcNVQfhNsIkYtHZqmIxA';
  int limit = 10;
  String category = 'Linux';
  String difficulty = 'easy';


  Uri getUri() {
    return Uri.parse(apiUrl).replace(
      queryParameters: {
        'apiKey': 'P0caeBeQukpTAkc15r6aEcNVQfhNsIkYtHZqmIxA',
        'limit': limit.toString(),
        'category': category,
        'difficulty': difficulty,
      },
    );
  }

  Future<http.Response> sendRequest() async {
    final uri = getUri();
    return await http.get(uri);
  }
}