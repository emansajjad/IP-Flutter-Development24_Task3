import 'package:flutter/material.dart';

// Resultscreen widget to display the results of the quiz
class Resultscreen extends StatefulWidget {
  final int score; // The user's score
  final int Totalques; // Total number of questions in the quiz
  final List<String> SelectedAnswers; // List of answers selected by the user
  final List<String> CorrectedAnswers; // List of correct answers

  // Constructor for Resultscreen with required parameters
  const Resultscreen({
    Key? key,
    required this.score,
    required this.Totalques,
    required this.SelectedAnswers,
    required this.CorrectedAnswers,
  }) : super(key: key);

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Padding around the body
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align items at the start
          children: [
            const Text(
              "Quiz Completed!", // Title for quiz completion
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6), // Space between elements
            const Text(
              "Your Score:", // Label for score display
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.score}/${widget.Totalques}', // Display score and total questions
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900), // Score text styling
            ),
            const SizedBox(height: 6),
            const Text(
              "Review Answers:", // Label for answer review section
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget
                    .Totalques, // Total number of questions for the ListView
                itemBuilder: (context, index) {
                  // Determine if the selected answer is correct
                  bool isCorrect = widget.SelectedAnswers[index] ==
                      widget.CorrectedAnswers[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0), // Vertical padding for each answer
                    child: Container(
                      decoration: BoxDecoration(
                        // Background color based on whether the answer is correct or not
                        color: isCorrect
                            ? Colors.green
                                .withOpacity(0.1) // Light green for correct
                            : Colors.red
                                .withOpacity(0.1), // Light red for incorrect
                        borderRadius: BorderRadius.circular(
                            10), // Rounded corners for the container
                        border: Border.all(
                          color: isCorrect
                              ? Colors.green
                              : Colors
                                  .red, // Border color matches the background
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          'Question ${index + 1}: ${widget.SelectedAnswers[index]}', // Display selected answer
                          style: TextStyle(
                            color: isCorrect
                                ? Colors.green
                                : Colors.red, // Text color based on correctness
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Correct Answer: ${widget.CorrectedAnswers[index]}', // Display correct answer
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: Icon(
                          isCorrect
                              ? Icons.check_circle
                              : Icons.cancel, // Icon based on correctness
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16), // Space before the restart button
            ElevatedButton(
              onPressed: () {
                // Action when the button is pressed
                Navigator.popUntil(
                    context,
                    (route) =>
                        route.isFirst); // Navigate back to the first screen
              },
              child: const Text(
                'Restart Quiz', // Button label
                style: TextStyle(color: Colors.white), // Text color for button
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Button background color
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0), // Padding for button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners for the button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
