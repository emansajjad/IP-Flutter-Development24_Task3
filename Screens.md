Screens Overview
1. Start Screen (start_app.dart)
Purpose: The welcome screen that users see when they first open the app.
UI Elements:
A decorative logo with a gradient background.
A welcoming message that introduces the user to Brainbox and the quiz challenge.
A "Start Quiz" button that navigates to the quiz screen.
Navigation:
Pressing the "Start Quiz" button takes the user to the QuizScreenState for the actual quiz.
2. Quiz Screen (quiz_screen.dart)
Purpose: Contains the quiz questions, tracks user answers, and calculates the final score.
Key Features:
Displays one question at a time, with multiple-choice answers.
Buttons for each answer, allowing users to select their response.
Once all questions are answered, the score is calculated and displayed.
A "Restart Quiz" button appears on the completion screen, allowing the user to retake the quiz.
State Management:
Tracks the current question and selected answers.
Compares selected answers with the correct ones to compute the score at the end.
3. Main File (main.dart)
Purpose: The entry point of the application.
Configuration:
Initializes the app with the StartApp widget as the home screen.
Configures the app theme (Material3 is used here) and sets the title to "Quiz App".
