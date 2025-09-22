import 'package:flutter/material.dart';

// Provider for User Score state management
class UserScoreProvider with ChangeNotifier {
  int _lowestScore = 0;
  int _highestScore = 0;

  int get lowestScore => _lowestScore;
  int get highestScore => _highestScore;

  void updateScores(int score) {
    if (_lowestScore == 0 || score < _lowestScore) {
      _lowestScore = score;
    }
    if (score > _highestScore) {
      _highestScore = score;
    }
    notifyListeners();
  }

  void resetScores() {
    _lowestScore = 0;
    _highestScore = 0;
    notifyListeners();
  }
}
