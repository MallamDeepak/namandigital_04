import 'package:flutter/material.dart';

// Optimized widget for displaying a question card
class QuestionCard extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final String? selectedOption;
  final void Function(String) onOptionSelected;
  final bool showFeedback;
  final String correctAnswer;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.showFeedback,
    required this.correctAnswer,
  });

  Widget _buildOptionButton(String option) {
    final isSelected = selectedOption == option;
    final isCorrect = showFeedback && option == correctAnswer;
    final isWrong = showFeedback && isSelected && !isCorrect;
    
    Color backgroundColor;
    Color textColor;
    
    if (showFeedback) {
      backgroundColor = isCorrect ? Colors.green : (isWrong ? Colors.red : Colors.grey[800]!);
      textColor = Colors.white;
    } else {
      backgroundColor = isSelected ? Colors.yellow[700]! : Colors.grey[900]!;
      textColor = isSelected ? Colors.black : Colors.white;
    }

    return MouseRegion(
      cursor: showFeedback ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            minimumSize: const Size.fromHeight(52),
            elevation: isSelected ? 4 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ).copyWith(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.hovered) && !showFeedback && !isSelected) {
                return Colors.orange.withValues(alpha: 0.8);
              }
              return backgroundColor;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.hovered) && !showFeedback && !isSelected) {
                return Colors.white;
              }
              return textColor;
            }),
          ),
          onPressed: showFeedback ? null : () => onOptionSelected(option),
          child: Text(
            option, 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questionText,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...options.map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _buildOptionButton(option),
            )),
          ],
        ),
      ),
    );
  }
}
