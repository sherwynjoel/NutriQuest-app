import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/game_provider.dart';
import '../../../core/models/game_models.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  bool _showResult = false;
  int _correctAnswers = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Nutrition Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (gameProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gameProvider.quizQuestions.isEmpty) {
            return const Center(
              child: Text('No questions available'),
            );
          }

          final question = gameProvider.quizQuestions[_currentQuestionIndex];
          final isLastQuestion = _currentQuestionIndex == gameProvider.quizQuestions.length - 1;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress bar
                _buildProgressBar(),
                
                const SizedBox(height: 24),
                
                // Question card
                Expanded(
                  child: _buildQuestionCard(question),
                ),
                
                const SizedBox(height: 24),
                
                // Action buttons
                _buildActionButtons(gameProvider, isLastQuestion),
              ],
            ),
          );
        },
      ),
    );

  Widget _buildProgressBar() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$_correctAnswers correct',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.successGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / context.read<GameProvider>().quizQuestions.length,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
        ),
      ],
    );

  Widget _buildQuestionCard(QuizQuestion question) => Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
                height: 1.3,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Options
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = _selectedAnswer == index;
              final isCorrect = _showResult && question.correctAnswer == index;
              final isWrong = _showResult && isSelected && question.correctAnswer != index;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _showResult ? null : () {
                      setState(() {
                        _selectedAnswer = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getOptionColor(isSelected, isCorrect, isWrong),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getOptionBorderColor(isSelected, isCorrect, isWrong),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _getOptionIconColor(isSelected, isCorrect, isWrong),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: _getOptionIcon(isSelected, isCorrect, isWrong),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          Expanded(
                            child: Text(
                              option,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: _getOptionTextColor(isSelected, isCorrect, isWrong),
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            
            // Explanation
            if (_showResult) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.successGreen.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.lightbulb,
                          color: AppTheme.successGreen,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Explanation',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.successGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.explanation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOut);

  Widget _buildActionButtons(GameProvider gameProvider, bool isLastQuestion) => Row(
      children: [
        if (_showResult) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (isLastQuestion) {
                  _showQuizResults(gameProvider);
                } else {
                  _nextQuestion();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(isLastQuestion ? 'Finish Quiz' : 'Next Question'),
            ),
          ),
        ] else ...[
          Expanded(
            child: ElevatedButton(
              onPressed: _selectedAnswer != null ? _submitAnswer : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Submit Answer'),
            ),
          ),
        ],
      ],
    );

  Color _getOptionColor(bool isSelected, bool isCorrect, bool isWrong) {
    if (_showResult) {
      if (isCorrect) return AppTheme.successGreen.withOpacity(0.1);
      if (isWrong) return AppTheme.errorRed.withOpacity(0.1);
    }
    if (isSelected) return AppTheme.primaryGreen.withOpacity(0.1);
    return Colors.grey[100]!;
  }

  Color _getOptionBorderColor(bool isSelected, bool isCorrect, bool isWrong) {
    if (_showResult) {
      if (isCorrect) return AppTheme.successGreen;
      if (isWrong) return AppTheme.errorRed;
    }
    if (isSelected) return AppTheme.primaryGreen;
    return Colors.grey[300]!;
  }

  Color _getOptionIconColor(bool isSelected, bool isCorrect, bool isWrong) {
    if (_showResult) {
      if (isCorrect) return AppTheme.successGreen;
      if (isWrong) return AppTheme.errorRed;
    }
    if (isSelected) return AppTheme.primaryGreen;
    return Colors.grey[400]!;
  }

  Color _getOptionTextColor(bool isSelected, bool isCorrect, bool isWrong) {
    if (_showResult) {
      if (isCorrect) return AppTheme.successGreen;
      if (isWrong) return AppTheme.errorRed;
    }
    if (isSelected) return AppTheme.primaryGreen;
    return AppTheme.textDark;
  }

  Widget _getOptionIcon(bool isSelected, bool isCorrect, bool isWrong) {
    if (_showResult) {
      if (isCorrect) return const Icon(Icons.check, color: Colors.white, size: 16);
      if (isWrong) return const Icon(Icons.close, color: Colors.white, size: 16);
    }
    if (isSelected) return const Icon(Icons.radio_button_checked, color: Colors.white, size: 16);
    return const Icon(Icons.radio_button_unchecked, color: Colors.white, size: 16);
  }

  Future<void> _submitAnswer() async {
    if (_selectedAnswer == null) return;

    final gameProvider = context.read<GameProvider>();
    final question = gameProvider.quizQuestions[_currentQuestionIndex];
    final isCorrect = await gameProvider.submitQuizAnswer(question.id, _selectedAnswer!);

    setState(() {
      _showResult = true;
      if (isCorrect) _correctAnswers++;
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _showResult = false;
    });
  }

  void _showQuizResults(GameProvider gameProvider) {
    final totalQuestions = gameProvider.quizQuestions.length;
    final score = (_correctAnswers / totalQuestions * 100).round();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You scored $score%'),
            Text('$_correctAnswers out of $totalQuestions correct'),
            const SizedBox(height: 16),
            Text('You earned ${gameProvider.currentScore} XP!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/home');
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
