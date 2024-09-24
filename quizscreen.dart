import 'package:brainbox/resultscreen.dart';
import 'package:flutter/material.dart';

class QuizScreenState extends StatefulWidget {
  @override
  State<QuizScreenState> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreenState> {
  int currentQuestionIndex = 0; // Tracks the index of the current question
  List<String> selectedChoices = List.filled(10,
      ""); // Initializes a list for selected answers (assuming 10 questions)

  // List of questions with their choices and correct answers
  final List<Map<String, dynamic>> quesList = [
    {
      'question':
          'In Flutter, which method is used to pass data between screens?',
      'choices': [
        'Navigator.pop()',
        'setState()',
        'runApp()',
        'Navigator.push()'
      ],
      'answer': 'Navigator.push()'
    },
    {
      'question':
          'What does the pubspec.yaml file in a Flutter project contain?',
      'choices': [
        'Project dependencies and configurations',
        'Widget tree structure',
        'State management logic',
        'Compiled Flutter code'
      ],
      'answer': 'Project dependencies and configurations'
    },
    {
      'question':
          'Which widget in Flutter is used to create an invisible box for layout?',
      'choices': ['Column', 'Container', 'Stack', 'SizedBox'],
      'answer': 'SizedBox'
    },
    {
      'question': 'Which command is used to create a new Flutter project?',
      'choices': [
        'flutter new',
        'flutter create',
        'flutter init',
        'flutter build'
      ],
      'answer': 'flutter create'
    },
    {
      'question': 'What does IDE stand for in software development?',
      'choices': [
        'Integrated Development Environment',
        'Internet Development Editor',
        'Interactive Design Engine',
        'Integrated Debugging Engine'
      ],
      'answer': 'Integrated Development Environment'
    },
    {
      'question': 'Which widget in Flutter is used to display text?',
      'choices': ['Text', 'Button', 'Container', 'AppBar'],
      'answer': 'Text'
    },
    {
      'question': 'What is the main function used to run a Flutter app?',
      'choices': ['runApp()', 'mainApp()', 'startApp()', 'launchApp()'],
      'answer': 'runApp()'
    },
    {
      'question': 'Which of the following is a popular version control system?',
      'choices': ['Git', 'Docker', 'SQL', 'Python'],
      'answer': 'Git'
    },
    {
      'question': 'What is used to manage packages in a Flutter app?',
      'choices': ['Dart Packages', 'pubspec.yaml', 'npm', 'Maven'],
      'answer': 'pubspec.yaml'
    },
    {
      'question': 'Which programming language is used by Flutter?',
      'choices': ['Java', 'Kotlin', 'Swift', 'Dart'],
      'answer': 'Dart'
    },
  ];

  // Function to navigate to the next question or to the results screen
  void goToNextScreen() {
    setState(() {
      if (currentQuestionIndex < quesList.length - 1) {
        // If there are more questions, increment the index
        currentQuestionIndex++;
      } else {
        // If all questions have been answered, navigate to the results screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Resultscreen(
              score: intCalScore(), // Calculate score
              Totalques: quesList.length, // Total number of questions
              SelectedAnswers: getSelectedAnswers(), // Get selected answers
              CorrectedAnswers: getCorrectAnswers(), // Get correct answers
            ),
          ),
        );
      }
    });
  }

  // Function to calculate the total score based on selected answers
  int intCalScore() {
    int score = 0; // Initialize score
    for (int i = 0; i < quesList.length; i++) {
      // Loop through each question to compare selected answers with correct answers
      if (getSelectedAnswers()[i] == quesList[i]["answer"]) {
        score++; // Increment score for each correct answer
      }
    }
    return score; // Return total score
  }

  // Getter function to retrieve selected answers
  List<String> getSelectedAnswers() {
    return selectedChoices; // Return the list of selected choices
  }

  // Getter function to retrieve correct answers
  List<String> getCorrectAnswers() {
    // Map through the questions list to extract answers
    return quesList
        .map<String>(
            (question) => question['answer'] as String) // Extract answers
        .toList(); // Convert to a list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Time!",
            style: TextStyle(fontSize: 28, color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress bar indicating quiz progress
            Container(
              height: 10, // Thickness of the progress bar
              child: LinearProgressIndicator(
                value: currentQuestionIndex == 0
                    ? 0 // Progress is 0 if on the first question
                    : (currentQuestionIndex + 1) /
                        quesList.length, // Calculate progress
                backgroundColor: Colors
                    .grey.shade500, // Background color of the progress bar
                color: Colors.blue.shade900, // Progress color
                borderRadius: BorderRadius.circular(
                    11), // Rounded corners for the progress bar
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Question ${currentQuestionIndex + 1}/${quesList.length}', // Display current question number
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quesList[currentQuestionIndex]
                    ['question'], // Display the current question
                style: const TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(height: 25),
            // Display choices as radio buttons
            ...quesList[currentQuestionIndex]['choices'].map<Widget>((choice) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey), // Border color of the choice
                    borderRadius: BorderRadius.circular(
                        10), // Rounded corners for the choice container
                  ),
                  child: RadioListTile(
                    title: Text(choice), // Display choice text
                    value: choice, // Value for this choice
                    groupValue: selectedChoices[
                        currentQuestionIndex], // Group value for the current question
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedChoices[currentQuestionIndex] =
                              value as String; // Update the selected choice
                        });
                      }
                    },
                    activeColor:
                        Colors.blue.shade900, // Active color when selected
                    visualDensity: VisualDensity
                        .adaptivePlatformDensity, // Density for adaptive design
                    controlAffinity: ListTileControlAffinity
                        .leading, // Positioning of the radio button
                  ),
                ),
              );
            }).toList(), // Convert the list of widgets to a displayable list
            const SizedBox(height: 20),
            // 'Next' button to proceed to the next question or results screen
            ElevatedButton(
              onPressed: selectedChoices[currentQuestionIndex].isNotEmpty
                  ? goToNextScreen // Proceed if a choice is selected
                  : null, // Disable button if no choice is made
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10), // Reduced padding for a smaller button
                backgroundColor:
                    selectedChoices[currentQuestionIndex].isNotEmpty
                        ? Colors.blue.shade900 // Button color if active
                        : Colors.grey.shade400, // Disabled button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20), // Smaller border radius for the button
                  side: const BorderSide(color: Colors.grey), // Border color
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors
                        .white), // Slightly smaller font size for the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
