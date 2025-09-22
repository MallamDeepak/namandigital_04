import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Blaster Quiz',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.orange,
          secondary: Colors.orangeAccent,
        ),
        scaffoldBackgroundColor: const Color(0xFF181818),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int lowestScore = -1; // -1 means no score recorded yet
  int highestScore = 0;

  final List<Map<String, dynamic>> categories = const [
    {
      'icon': Icons.public,
      'label': 'General Knowledge',
      'questions': [
        {
          'question': 'What is the capital of France?',
          'options': ['Paris', 'London', 'Berlin', 'Madrid'],
          'answer': 'Paris',
        },
        {
          'question': 'Who wrote Hamlet?',
          'options': ['Shakespeare', 'Dickens', 'Austen', 'Hemingway'],
          'answer': 'Shakespeare',
        },
        {
          'question': 'What is the largest ocean?',
          'options': ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
          'answer': 'Pacific',
        },
        {
          'question': 'Which planet is known as the Red Planet?',
          'options': ['Mars', 'Venus', 'Jupiter', 'Saturn'],
          'answer': 'Mars',
        },
        {
          'question': 'What is H2O?',
          'options': ['Water', 'Oxygen', 'Hydrogen', 'Salt'],
          'answer': 'Water',
        },
        {
          'question': 'Who painted the Mona Lisa?',
          'options': ['Da Vinci', 'Picasso', 'Van Gogh', 'Rembrandt'],
          'answer': 'Da Vinci',
        },
        {
          'question': 'What is the currency of Japan?',
          'options': ['Yen', 'Won', 'Dollar', 'Euro'],
          'answer': 'Yen',
        },
        {
          'question': 'What is the boiling point of water?',
          'options': ['100°C', '0°C', '50°C', '200°C'],
          'answer': '100°C',
        },
        {
          'question': 'Who discovered gravity?',
          'options': ['Newton', 'Einstein', 'Galileo', 'Tesla'],
          'answer': 'Newton',
        },
        {
          'question': 'What is the largest continent?',
          'options': ['Asia', 'Africa', 'Europe', 'Australia'],
          'answer': 'Asia',
        },
      ],
    },
    {
      'icon': Icons.science,
      'label': 'Science',
      'questions': [
        {
          'question': 'What is the chemical symbol for gold?',
          'options': ['Au', 'Ag', 'Gd', 'Go'],
          'answer': 'Au',
        },
        {
          'question': 'What planet is closest to the sun?',
          'options': ['Mercury', 'Venus', 'Earth', 'Mars'],
          'answer': 'Mercury',
        },
        {
          'question': 'What is the speed of light?',
          'options': ['299,792 km/s', '150,000 km/s', '1,000 km/s', '3,000 km/s'],
          'answer': '299,792 km/s',
        },
        {
          'question': 'Who developed the theory of relativity?',
          'options': ['Einstein', 'Newton', 'Tesla', 'Curie'],
          'answer': 'Einstein',
        },
        {
          'question': 'What is the powerhouse of the cell?',
          'options': ['Mitochondria', 'Nucleus', 'Ribosome', 'Chloroplast'],
          'answer': 'Mitochondria',
        },
        {
          'question': 'What is the main gas in the air?',
          'options': ['Nitrogen', 'Oxygen', 'Carbon Dioxide', 'Hydrogen'],
          'answer': 'Nitrogen',
        },
        {
          'question': 'What is the hardest natural substance?',
          'options': ['Diamond', 'Gold', 'Iron', 'Quartz'],
          'answer': 'Diamond',
        },
        {
          'question': 'What is the process of plants making food?',
          'options': ['Photosynthesis', 'Respiration', 'Digestion', 'Fermentation'],
          'answer': 'Photosynthesis',
        },
        {
          'question': 'What is the center of an atom called?',
          'options': ['Nucleus', 'Electron', 'Proton', 'Neutron'],
          'answer': 'Nucleus',
        },
        {
          'question': 'What is the largest organ in the human body?',
          'options': ['Skin', 'Liver', 'Heart', 'Brain'],
          'answer': 'Skin',
        },
      ],
    },
    {
      'icon': Icons.history_edu,
      'label': 'History',
      'questions': [
        {
          'question': 'Who was the first President of the USA?',
          'options': ['George Washington', 'Abraham Lincoln', 'John Adams', 'Thomas Jefferson'],
          'answer': 'George Washington',
        },
        {
          'question': 'In which year did World War II end?',
          'options': ['1945', '1939', '1918', '1950'],
          'answer': '1945',
        },
        {
          'question': 'Who built the pyramids?',
          'options': ['Egyptians', 'Romans', 'Greeks', 'Chinese'],
          'answer': 'Egyptians',
        },
        {
          'question': 'Who discovered America?',
          'options': ['Columbus', 'Magellan', 'Cook', 'Vespucci'],
          'answer': 'Columbus',
        },
        {
          'question': 'Who was known as the Maid of Orleans?',
          'options': ['Joan of Arc', 'Cleopatra', 'Elizabeth I', 'Marie Antoinette'],
          'answer': 'Joan of Arc',
        },
        {
          'question': 'What wall divided Berlin?',
          'options': ['Berlin Wall', 'Great Wall', 'Hadrian’s Wall', 'Iron Curtain'],
          'answer': 'Berlin Wall',
        },
        {
          'question': 'Who was the first man on the moon?',
          'options': ['Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'John Glenn'],
          'answer': 'Neil Armstrong',
        },
        {
          'question': 'Who was the British PM during WWII?',
          'options': ['Winston Churchill', 'Neville Chamberlain', 'Margaret Thatcher', 'Tony Blair'],
          'answer': 'Winston Churchill',
        },
        {
          'question': 'What year did India gain independence?',
          'options': ['1947', '1950', '1930', '1962'],
          'answer': '1947',
        },
        {
          'question': 'Who wrote the Declaration of Independence?',
          'options': ['Thomas Jefferson', 'Benjamin Franklin', 'John Adams', 'George Washington'],
          'answer': 'Thomas Jefferson',
        },
      ],
    },
  ];

  void updateScores(int score) {
    setState(() {
      // For lowest score: if this is the first score (lowestScore == -1) or current score is lower
      if (lowestScore == -1 || score < lowestScore) {
        lowestScore = score;
      }
      // For highest score: if current score is higher
      if (score > highestScore) {
        highestScore = score;
      }
    });
  }

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
              ...categories.map((cat) => _categoryButton(
                context,
                cat['icon'] as IconData,
                cat['label'] as String,
                cat['questions'] as List,
              )),
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
            Text(
              score == -1 ? '--' : '$score', 
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(BuildContext context, IconData icon, String label, List questions) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(label, style: const TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
        ),
        onPressed: () async {
          final score = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuizScreen(
                questions: questions, 
                category: label,
                onScoreUpdate: updateScores,
              ),
            ),
          );
          if (score is int) updateScores(score);
        },
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final List questions;
  final String category;
  final Function(int)? onScoreUpdate;
  
  const QuizScreen({
    super.key, 
    required this.questions, 
    required this.category,
    this.onScoreUpdate,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  List<String?> userAnswers = [];
  int secondsLeft = 120;
  Timer? timer;
  String? selectedOption;
  bool showFeedback = false;
  late List<Map<String, dynamic>> shuffledQuestions;

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
    userAnswers = List.filled(shuffledQuestions.length, null);
    _startTimer();
  }

  void _shuffleQuestions() {
    final random = Random();
    shuffledQuestions = widget.questions.map<Map<String, dynamic>>((question) {
      // Create a copy of the question
      final Map<String, dynamic> shuffledQuestion = Map.from(question);
      
      // Get the original options and shuffle them
      List<String> options = List<String>.from(question['options']);
      options.shuffle(random);
      
      // Update the shuffled question with new options order
      shuffledQuestion['options'] = options;
      
      return shuffledQuestion;
    }).toList();
    
    // Also shuffle the order of questions themselves for more variety
    shuffledQuestions.shuffle(random);
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else {
          t.cancel();
          _submitAnswer();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _selectOption(String option) {
    if (showFeedback) return; // Prevent multiple selections
    
    timer?.cancel(); // Cancel the current timer first
    
    // Immediate UI feedback - just set selected option
    setState(() {
      selectedOption = option;
    });
    
    // Process the answer logic
    userAnswers[currentIndex] = option;
    if (option == shuffledQuestions[currentIndex]['answer']) {
      score++;
    }
    
    // Show feedback after a brief delay for immediate visual response
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          showFeedback = true;
        });
        
        // Wait to show feedback, then move to next question
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            _moveToNext();
          }
        });
      }
    });
  }
  
  void _moveToNext() {
    setState(() {
      showFeedback = false;
      selectedOption = null;
      if (currentIndex < shuffledQuestions.length - 1) {
        currentIndex++;
        secondsLeft = 120;
        _startTimer();
      } else {
        timer?.cancel();
        // Update scores via callback
        widget.onScoreUpdate?.call(score);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: score,
              totalQuestions: shuffledQuestions.length,
              category: widget.category,
            ),
          ),
        );
      }
    });
  }

  void _submitAnswer() {
    timer?.cancel();
    _moveToNext();
  }

  Widget _buildAnswerButton(String option, String correctAnswer) {
    final isCorrect = showFeedback && option == correctAnswer;
    final isSelected = selectedOption == option;
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
          onPressed: showFeedback ? null : () => _selectOption(option),
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
    final question = shuffledQuestions[currentIndex];
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
              'Question ${currentIndex + 1} of ${shuffledQuestions.length}',
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: _buildAnswerButton(opt, question['answer']),
              );
            }),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Left: ${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 18, color: Colors.orange),
                ),
                if (showFeedback) 
                  const SizedBox()
                else
                  ElevatedButton(
                    onPressed: _submitAnswer,
                    child: const Text('Skip'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String category;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Category: $category',
                style: const TextStyle(fontSize: 20, color: Colors.orange),
              ),
              const SizedBox(height: 24),
              Text(
                'Score: $score / $totalQuestions',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                'Correct Answers: $score',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}