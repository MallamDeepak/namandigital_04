import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int lowestScore;
  final int highestScore;
  final void Function(int) onScoreUpdate;

  const HomeScreen({
    super.key,
    this.lowestScore = 0,
    this.highestScore = 0,
    required this.onScoreUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brain Blaster Quiz'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _scoreCard('Lowest Score', lowestScore),
                  _scoreCard('Highest Score', highestScore),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Select a Category to Start',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              // TODO: Add category selection buttons here
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreCard(String label, int score) {
    return Card(
      color: Colors.grey[900],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.orange)),
            const SizedBox(height: 8),
            Text('$score', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}