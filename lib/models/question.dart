class Question {
  final String id;
  final String category;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final int points;

  Question({
    required this.id,
    required this.category,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.points = 1,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      category: json['category'],
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      points: json['points'] ?? 1,
    );
  }
}
