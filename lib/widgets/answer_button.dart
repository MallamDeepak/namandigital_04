import 'package:flutter/material.dart';

// Optimized widget for answer button with hover effects
class AnswerButton extends StatelessWidget {
  final String optionText;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isCorrect;
  final bool showFeedback;

  const AnswerButton({
    super.key,
    required this.optionText,
    required this.onPressed,
    this.isSelected = false,
    this.isCorrect = false,
    this.showFeedback = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    
    if (showFeedback) {
      bgColor = isCorrect ? Colors.green : (isSelected ? Colors.red : Colors.grey[800]!);
      textColor = Colors.white;
    } else {
      bgColor = isSelected ? Colors.yellow[700]! : Colors.grey[900]!;
      textColor = isSelected ? Colors.black : Colors.white;
    }

    return MouseRegion(
      cursor: showFeedback ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
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
              return bgColor;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.hovered) && !showFeedback && !isSelected) {
                return Colors.white;
              }
              return textColor;
            }),
          ),
          onPressed: showFeedback ? null : onPressed,
          child: Text(
            optionText, 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
