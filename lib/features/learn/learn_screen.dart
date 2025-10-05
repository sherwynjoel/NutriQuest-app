import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Learn'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            _buildWelcomeSection(),
            
            const SizedBox(height: 24),
            
            // Nutrition facts
            _buildNutritionFacts(),
            
            const SizedBox(height: 24),
            
            // Food pyramid
            _buildFoodPyramid(),
            
            const SizedBox(height: 24),
            
            // Tips section
            _buildTipsSection(),
          ],
        ),
      ),
    );

  Widget _buildWelcomeSection() => Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.school, color: AppTheme.primaryGreen, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Nutrition Learning Hub',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Discover the fundamentals of healthy eating and nutrition. Learn about different food groups, their benefits, and how to create balanced meals.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textLight,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut);

  Widget _buildNutritionFacts() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Facts',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 16),
        _buildFactCard(
          'Vitamins & Minerals',
          'Essential nutrients that help your body function properly. Found in fruits, vegetables, and whole grains.',
          Icons.eco,
          AppTheme.primaryGreen,
        ),
        const SizedBox(height: 12),
        _buildFactCard(
          'Protein',
          'Builds and repairs tissues. Found in meat, fish, beans, and nuts.',
          Icons.restaurant,
          AppTheme.errorRed,
        ),
        const SizedBox(height: 12),
        _buildFactCard(
          'Carbohydrates',
          'Provide energy for your body. Choose whole grains over refined carbs.',
          Icons.grain,
          AppTheme.accentOrange,
        ),
      ],
    );

  Widget _buildFactCard(String title, String description, IconData icon, Color color) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textLight,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.3, end: 0, curve: Curves.easeOut);

  Widget _buildFoodPyramid() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Food Pyramid',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildPyramidLevel('Fats & Oils', 'Use sparingly', AppTheme.accentYellow, 0.3),
                _buildPyramidLevel('Dairy', '2-3 servings', Colors.blue, 0.4),
                _buildPyramidLevel('Protein', '2-3 servings', AppTheme.errorRed, 0.5),
                _buildPyramidLevel('Vegetables', '3-5 servings', AppTheme.primaryGreen, 0.6),
                _buildPyramidLevel('Fruits', '2-4 servings', AppTheme.accentOrange, 0.7),
                _buildPyramidLevel('Grains', '6-11 servings', Colors.brown, 0.8),
              ],
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOut);

  Widget _buildPyramidLevel(String title, String servings, Color color, double width) => Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * width,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              servings,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textLight,
              ),
            ),
          ),
        ],
      ),
    );

  Widget _buildTipsSection() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Healthy Eating Tips',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 16),
        _buildTipCard(
          'Drink Water',
          'Stay hydrated by drinking 8 glasses of water daily.',
          Icons.water_drop,
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _buildTipCard(
          'Eat Rainbow',
          'Include colorful fruits and vegetables in every meal.',
          Icons.eco,
          AppTheme.primaryGreen,
        ),
        const SizedBox(height: 12),
        _buildTipCard(
          'Portion Control',
          'Use smaller plates and listen to your hunger cues.',
          Icons.balance,
          AppTheme.accentOrange,
        ),
      ],
    );

  Widget _buildTipCard(String title, String description, IconData icon, Color color) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.3, end: 0, curve: Curves.easeOut);
}
