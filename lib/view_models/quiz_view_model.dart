import 'package:flutter/material.dart';
import 'package:quiz_app/service/api_service.dart';
import 'package:quiz_app/models/quiz_model.dart';

class QuizViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  QuizModel? _quiz;
  int _currentQuestionIndex = 0;
  List<int> _selectedAnswers = [];
  bool _isLoading = false;
  int _score = 0;
  int _lives = 3;

  QuizModel? get quiz => _quiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isLoading => _isLoading;
  int get score => _score;
  int get lives => _lives;

  Future<void> loadQuiz() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quiz = await _apiService.fetchQuizData();
      _selectedAnswers = List.filled(_quiz!.questions.length, -1);
    } catch (e) {
      print('Error loading quiz: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    if (_currentQuestionIndex < _selectedAnswers.length) {
      _selectedAnswers[_currentQuestionIndex] = optionIndex;
      
      // Check if answer is correct
      final currentQuestion = _quiz!.questions[_currentQuestionIndex];
      final isCorrect = currentQuestion.options[optionIndex].isCorrect;
      
      if (isCorrect) {
        _score += _quiz!.correctAnswerMarks.toInt();
      } else {
        _score -= _quiz!.negativeMarks.toInt();
        _lives--;
      }
      
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _quiz!.questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  bool get isQuizComplete => 
    _currentQuestionIndex == _quiz!.questions.length - 1 && 
    _selectedAnswers[_currentQuestionIndex] != -1;

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswers = [];
    _score = 0;
    _lives = 3;
    notifyListeners();
  }
}