import 'package:flutter/material.dart';



class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  final List<Question> questions = [
    Question(
      questionText: 'What is the capital of France?',
      options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'Which planet is known as the Red Planet?',
      options: ['Mars', 'Venus', 'Jupiter', 'Saturn'],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: 'What is the largest mammal in the world?',
      options: ['Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
      correctAnswerIndex: 1,
    ),
  ];

  void answerQuestion(int selectedAnswerIndex) {
    if (selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        correctAnswers++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResultsDialog();
    }
  }

  void _showResultsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Text('You got $correctAnswers out of ${questions.length} questions correct!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  currentQuestionIndex = 0;
                  correctAnswers = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Question ${currentQuestionIndex + 1}:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                questions[currentQuestionIndex].questionText,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 16.0),
              ...List.generate(
                questions[currentQuestionIndex].options.length,
                    (index) => ElevatedButton(
                  onPressed: () => answerQuestion(index),
                  child: Text(questions[currentQuestionIndex].options[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

