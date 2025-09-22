import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final Duration duration;
  final VoidCallback onTimerEnd;

  const TimerWidget({super.key, required this.duration, required this.onTimerEnd});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late Duration _currentDuration;

  @override
  void initState() {
    super.initState();
    _currentDuration = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentDuration.inSeconds > 0) {
        setState(() {
          _currentDuration -= const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        widget.onTimerEnd();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(_currentDuration.inMinutes.remainder(60));
    String seconds = twoDigits(_currentDuration.inSeconds.remainder(60));
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.timer, color: Colors.orange),
          const SizedBox(width: 8),
          Text('$minutes:$seconds', style: const TextStyle(fontSize: 20, color: Colors.orange)),
        ],
      ),
    );
  }
}