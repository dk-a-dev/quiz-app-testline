import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/view_models/quiz_view_model.dart';
import 'package:quiz_app/screens/home_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController confettiController;
  late AnimationController animationController;
  late Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();

    confettiController =
        ConfettiController(duration: const Duration(seconds: 5));

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final score = Provider.of<QuizViewModel>(context, listen: false).score;

    _scoreAnimation = Tween<double>(
      begin: 0,
      end: score.toDouble(),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    if (score >= 5) {
      confettiController.play();
    }
    animationController.forward();
  }

  @override
  void dispose() {
    confettiController.dispose();
    animationController.dispose();
    super.dispose();
  }

  String _getPerformanceMessage(int score, int totalPossibleScore) {
    final percentage = (score / totalPossibleScore) * 100;
    if (percentage >= 90) return "Outstanding!";
    if (percentage >= 80) return "Excellent Work!";
    if (percentage >= 70) return "Good Job!";
    if (percentage >= 60) return "Nice Try!";
    if (percentage >= 40) return "Keep Practicing!";
    return "Don't Give Up!";
  }

  String _getMotivationalMessage(int score) {
    if (score < 5) {
      return "Everyone has tough days! Let's try again and improve together.";
    }
    return "Great effort! Keep up the good work!";
  }

  String _getLottieAnimation(int score) {
    if (score < 5) {
      return 'assets/animations/try-again.json';
    }
    return 'assets/animations/trophy.json';
  }

  Color _getBackgroundColor(int score) {
    if (score < 5) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, quizVM, child) {
        final score = quizVM.score;
        final totalQuestions = quizVM.quiz!.questions.length;
        final totalPossibleScore =
            totalQuestions * quizVM.quiz!.correctAnswerMarks;
        final backgroundColor = _getBackgroundColor(score);

        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[300]!,
                      Colors.blue[600]!,
                    ],
                  ),
                ),
              ),
              if (score >= 5)
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: confettiController,
                    blastDirection: Math.pi / 2,
                    maxBlastForce: 5,
                    minBlastForce: 2,
                    emissionFrequency: 0.05,
                    numberOfParticles: 50,
                    gravity: 0.05,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                  ),
                ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      _getLottieAnimation(score),
                      height: 200,
                      repeat: score < 5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      score < 5 ? 'Keep Going!' : 'Quiz Complete!',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _scoreAnimation,
                      builder: (context, child) {
                        return Text(
                          'Score: ${_scoreAnimation.value.toInt()}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getPerformanceMessage(score, totalPossibleScore.toInt()),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        _getMotivationalMessage(score),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            quizVM.resetQuiz();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false,
                            );
                          },
                          icon: Icon(score < 5 ? Icons.refresh : Icons.replay),
                          label: Text(score < 5 ? 'Try Again!' : 'Play Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: backgroundColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        if (score >= 5)
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Share functionality coming soon!'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: backgroundColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
