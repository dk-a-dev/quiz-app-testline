import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/quiz_model.dart';

class ApiService {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<QuizModel> fetchQuizData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return QuizModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}