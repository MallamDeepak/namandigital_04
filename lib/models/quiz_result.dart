class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final String category;
  final Duration timeTaken;

  QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.category,
    required this.timeTaken,
  });
}
