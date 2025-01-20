import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/view_models/quiz_view_model.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, quizVM, child) {
        if (quizVM.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentQuestion = quizVM.quiz!.questions[quizVM.currentQuestionIndex];

        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${quizVM.currentQuestionIndex + 1}/${quizVM.quiz!.questions.length}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          quizVM.lives,
                          (index) => const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentQuestion.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(currentQuestion.options[index].description),
                            onTap: () {
                              quizVM.selectAnswer(index);
                              if (quizVM.lives <= 0) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResultScreen(),
                                  ),
                                );
                              } else if (quizVM.isQuizComplete) {
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ResultScreen(),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () => quizVM.nextQuestion(),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (quizVM.currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: quizVM.previousQuestion,
                          child: const Text('Previous'),
                        ),
                      Text(
                        'Score: ${quizVM.score}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}