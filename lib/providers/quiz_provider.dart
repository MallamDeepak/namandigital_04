import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<String?> _userAnswers = [];
  bool _quizFinished = false;

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get quizFinished => _quizFinished;
  Question? get currentQuestion => _questions.isNotEmpty && _currentQuestionIndex < _questions.length
      ? _questions[_currentQuestionIndex]
      : null;
  int get totalQuestions => _questions.length;
  List<String?> get userAnswers => _userAnswers;

  void loadQuestions(List<Question> questions) {
    _questions = questions;
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers = List.filled(questions.length, null);
    _quizFinished = false;
    notifyListeners();
  }

  void answerQuestion(String answer) {
    if (_quizFinished || currentQuestion == null) return;
    _userAnswers[_currentQuestionIndex] = answer;
    if (answer == currentQuestion!.correctAnswer) {
      _score++;
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _quizFinished = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers = List.filled(_questions.length, null);
    _quizFinished = false;
    notifyListeners();
  }
}
