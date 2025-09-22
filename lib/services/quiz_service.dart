// Service for fetching quiz data

class QuizService {
  // Example: Load questions for a category
  static List<Map<String, dynamic>> getQuestionsForCategory(String category) {
    // TODO: Replace with actual data source or API
    // This is a stub for demonstration
    if (category == 'General Knowledge') {
      return [
        {
          'question': 'What is the capital of France?',
          'options': ['Paris', 'London', 'Berlin', 'Madrid'],
          'answer': 'Paris',
        },
        // ...more questions...
      ];
    }
    // Add more categories as needed
    return [];
  }
}
