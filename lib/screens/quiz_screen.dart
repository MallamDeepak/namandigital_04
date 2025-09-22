import 'package:flutter/material.dart';
import '../widgets/timer_widget.dart';

class QuizScreen extends StatefulWidget {
  final List questions;
  final String category;
  const QuizScreen({super.key, required this.questions, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  bool showFeedback = false;
  String? selectedOption;
  int secondsLeft = 120;

  void _selectOption(String option) {
    setState(() {
      selectedOption = option;
      showFeedback = true;
    });
  }

  void _submitAnswer() {
    final question = widget.questions[currentIndex];
    if (selectedOption == question['answer']) {
      score++;
    }
    setState(() {
      showFeedback = false;
      selectedOption = null;
      if (currentIndex < widget.questions.length - 1) {
        currentIndex++;
        secondsLeft = 120;
      } else {
        Navigator.pop(context, score);
      }
    });
  }

  void _onTimerEnd() {
    _submitAnswer();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentIndex + 1} of ${widget.questions.length}',
              style: const TextStyle(fontSize: 18, color: Colors.orange),
            ),
            const SizedBox(height: 16),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(question['options'].length, (i) {
              final opt = question['options'][i];
              final isCorrect = showFeedback && opt == question['answer'];
              final isSelected = selectedOption == opt;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showFeedback
                        ? (isCorrect
                            ? Colors.green
                            : (isSelected ? Colors.red : Colors.grey[800]))
                        : (isSelected ? Colors.orange : Colors.grey[900]),
                  ),
                  onPressed: showFeedback ? null : () => _selectOption(opt),
                  child: Text(opt, style: const TextStyle(fontSize: 18)),
                ),
              );
            }),
            const SizedBox(height: 32),
            TimerWidget(
              duration: Duration(seconds: secondsLeft),
              onTimerEnd: _onTimerEnd,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: showFeedback || selectedOption == null ? null : _submitAnswer,
              child: Text(currentIndex == widget.questions.length - 1 ? 'Finish' : 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}
