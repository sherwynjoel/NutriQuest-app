import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/game_provider.dart';
import '../../../core/models/game_models.dart';

class MealBuilderScreen extends StatefulWidget {
  const MealBuilderScreen({super.key});

  @override
  State<MealBuilderScreen> createState() => _MealBuilderScreenState();
}

class _MealBuilderScreenState extends State<MealBuilderScreen> {
  final List<String> _selectedComponents = [];
  bool _showResults = false;
  int _mealScore = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Meal Builder'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          if (_selectedComponents.isNotEmpty)
            TextButton(
              onPressed: _showResults ? null : _buildMeal,
              child: const Text('Build Meal'),
            ),
        ],
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (gameProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gameProvider.mealComponents.isEmpty) {
            return const Center(
              child: Text('No meal components available'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Instructions
                if (!_showResults) _buildInstructions(),
                
                const SizedBox(height: 16),
                
                // Meal components
                Expanded(
                  child: _buildMealComponents(gameProvider.mealComponents),
                ),
                
                const SizedBox(height: 16),
                
                // Selected components
                if (_selectedComponents.isNotEmpty && !_showResults)
                  _buildSelectedComponents(),
                
                // Results
                if (_showResults) _buildResults(),
              ],
            ),
          );
        },
      ),
    );

  Widget _buildInstructions() => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                Text(
                  'Build a Balanced Meal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Select foods from different categories to create a balanced meal. Include protein, carbohydrates, and vegetables for bonus points!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut);

  Widget _buildMealComponents(List<MealComponent> components) => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: components.length,
      itemBuilder: (context, index) {
        final component = components[index];
        final isSelected = _selectedComponents.contains(component.id);
        
        return GestureDetector(
          onTap: _showResults ? null : () => _toggleComponent(component.id),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryGreen.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.primaryGreen : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Food image placeholder
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(component.category).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(component.category),
                    size: 30,
                    color: _getCategoryColor(component.category),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  component.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  _getCategoryLabel(component.category),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textLight,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 4),
                
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryGreen,
                    size: 20,
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
      },
    );

  Widget _buildSelectedComponents() => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Components (${_selectedComponents.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedComponents.map((componentId) {
                final component = context.read<GameProvider>().mealComponents
                    .firstWhere((c) => c.id == componentId);
                return Chip(
                  label: Text(component.name),
                  backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () => _toggleComponent(componentId),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOut);

  Widget _buildResults() => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.emoji_events,
              size: 48,
              color: AppTheme.accentYellow,
            ),
            const SizedBox(height: 16),
            Text(
              'Meal Complete!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You earned $_mealScore points!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedComponents.clear();
                      _showResults = false;
                      _mealScore = 0;
                    });
                  },
                  child: const Text('Build Another'),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Continue'),
                ),
              ],
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

  void _toggleComponent(String componentId) {
    setState(() {
      if (_selectedComponents.contains(componentId)) {
        _selectedComponents.remove(componentId);
      } else {
        _selectedComponents.add(componentId);
      }
    });
  }

  Future<void> _buildMeal() async {
    final gameProvider = context.read<GameProvider>();
    final score = await gameProvider.calculateMealScore(_selectedComponents);
    
    setState(() {
      _mealScore = score;
      _showResults = true;
    });
  }

  Color _getCategoryColor(MealCategory category) {
    switch (category) {
      case MealCategory.protein:
        return AppTheme.errorRed;
      case MealCategory.carbohydrate:
        return AppTheme.accentOrange;
      case MealCategory.vegetable:
        return AppTheme.primaryGreen;
      case MealCategory.fruit:
        return AppTheme.accentYellow;
      case MealCategory.dairy:
        return Colors.blue;
    }
  }

  IconData _getCategoryIcon(MealCategory category) {
    switch (category) {
      case MealCategory.protein:
        return Icons.restaurant;
      case MealCategory.carbohydrate:
        return Icons.grain;
      case MealCategory.vegetable:
        return Icons.eco;
      case MealCategory.fruit:
        return Icons.apple;
      case MealCategory.dairy:
        return Icons.local_drink;
    }
  }

  String _getCategoryLabel(MealCategory category) {
    switch (category) {
      case MealCategory.protein:
        return 'Protein';
      case MealCategory.carbohydrate:
        return 'Carbs';
      case MealCategory.vegetable:
        return 'Vegetable';
      case MealCategory.fruit:
        return 'Fruit';
      case MealCategory.dairy:
        return 'Dairy';
    }
  }
}
