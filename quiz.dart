import 'package:flutter/material.dart';

class QuizScreenState extends StatefulWidget {
  @override
  State<QuizScreenState> createState() => _QuizScreenStateState();
}

class _QuizScreenStateState extends State<QuizScreenState> {
  int currentQuestion = 0;
  List<String> selectedAnswers = [];

  final List<String> correctAnswers = [
    'Dart',
    'Text',
    'runApp()',
    'Integrated Development Environment',
    'Git'
  ];

  final List<Map<String, dynamic>> easyQuestions = [
    {
      'question': 'What programming language is used to write Flutter apps?',
      'options': ['Dart', 'Java', 'Python', 'Swift'],
    },
    {
      'question': 'Which widget in Flutter is used to display text?',
      'options': ['Text', 'Button', 'Container', 'AppBar'],
    },
    {
      'question': 'What is the main function used to run a Flutter app?',
      'options': ['runApp()', 'mainApp()', 'startApp()', 'launchApp()'],
    },
    {
      'question': 'What does IDE stand for in software development?',
      'options': [
        'Integrated Development Environment',
        'Internet Development Editor',
        'Interactive Design Engine',
        'Integrated Debugging Engine',
      ],
    },
    {
      'question': 'Which of the following is a popular version control system?',
      'options': ['Git', 'Docker', 'SQL', 'Python'],
    },
  ];

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswers.add(answer);
      currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    int score = 0;

    // Calculate score
    if (currentQuestion >= easyQuestions.length) {
      score = selectedAnswers.asMap().entries.where((entry) {
        return entry.value == correctAnswers[entry.key];
      }).length;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz Time!",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: currentQuestion < easyQuestions.length
          ? Padding(
              padding: const EdgeInsets.all(
                  20.0), // Adjusting padding around the quiz
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Padding around question text
                    child: Text(
                      easyQuestions[currentQuestion]['question'],
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ...easyQuestions[currentQuestion]['options'].map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical:
                              10.0), // More vertical space between options
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Colors.blue[900]!,
                              width: 2), // Use Colors.blue[900]!
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 40.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => selectAnswer(option),
                        child: Text(
                          option,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.pinkAccent),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(
                    20.0), // Padding for the completion container
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Quiz Completed!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Your Score:',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$score/${easyQuestions.length}',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestion = 0;
                            selectedAnswers.clear();
                          });
                        },
                        child: const Text(
                          'Restart Quiz',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
