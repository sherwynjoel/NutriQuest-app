import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/game_provider.dart';
import '../../../core/models/game_models.dart';

class FoodSortScreen extends StatefulWidget {
  const FoodSortScreen({super.key});

  @override
  State<FoodSortScreen> createState() => _FoodSortScreenState();
}

class _FoodSortScreenState extends State<FoodSortScreen> {
  int _currentItemIndex = 0;
  int _correctSorts = 0;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Food Sort'),
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

          if (gameProvider.foodItems.isEmpty) {
            return const Center(
              child: Text('No food items available'),
            );
          }

          final foodItem = gameProvider.foodItems[_currentItemIndex];
          final isLastItem = _currentItemIndex == gameProvider.foodItems.length - 1;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress
                _buildProgress(),
                
                const SizedBox(height: 24),
                
                // Food item
                Expanded(
                  child: _buildFoodItem(foodItem),
                ),
                
                const SizedBox(height: 24),
                
                // Sort buttons
                if (!_showResult) _buildSortButtons(gameProvider, foodItem),
                
                // Next button
                if (_showResult) _buildNextButton(isLastItem, gameProvider),
              ],
            ),
          );
        },
      ),
    );

  Widget _buildProgress() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Item ${_currentItemIndex + 1}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$_correctSorts correct',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.successGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        LinearProgressIndicator(
          value: (_currentItemIndex + 1) / context.read<GameProvider>().foodItems.length,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
        ),
      ],
    );

  Widget _buildFoodItem(FoodItem foodItem) => Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Food image placeholder
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.restaurant,
                size: 80,
                color: Colors.grey[400],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              foodItem.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              foodItem.nutritionFacts,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textLight,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          curve: Curves.easeOut,
        );

  Widget _buildSortButtons(GameProvider gameProvider, FoodItem foodItem) => Row(
      children: [
        Expanded(
          child: _buildSortButton(
            'Healthy',
            FoodCategory.healthy,
            AppTheme.successGreen,
            Icons.check_circle,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: _buildSortButton(
            'Unhealthy',
            FoodCategory.unhealthy,
            AppTheme.errorRed,
            Icons.cancel,
          ),
        ),
      ],
    );

  Widget _buildSortButton(
    String label,
    FoodCategory category,
    Color color,
    IconData icon,
  ) => ElevatedButton.icon(
      onPressed: () => _sortFood(category),
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

  Widget _buildNextButton(bool isLastItem, GameProvider gameProvider) => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (isLastItem) {
            _showGameResults(gameProvider);
          } else {
            _nextItem();
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(isLastItem ? 'Finish Game' : 'Next Item'),
      ),
    );

  Future<void> _sortFood(FoodCategory selectedCategory) async {
    final gameProvider = context.read<GameProvider>();
    final foodItem = gameProvider.foodItems[_currentItemIndex];
    final isCorrect = await gameProvider.sortFoodItem(foodItem.id, selectedCategory);

    setState(() {
      _showResult = true;
      if (isCorrect) _correctSorts++;
    });
  }

  void _nextItem() {
    setState(() {
      _currentItemIndex++;
      _showResult = false;
    });
  }

  void _showGameResults(GameProvider gameProvider) {
    final totalItems = gameProvider.foodItems.length;
    final score = (_correctSorts / totalItems * 100).round();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You scored $score%'),
            Text('$_correctSorts out of $totalItems correct'),
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
