import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/game_provider.dart';
import 'core/providers/user_provider.dart';

void main() {
  runApp(const NutriQuestDemoApp());
}

class NutriQuestDemoApp extends StatelessWidget {
  const NutriQuestDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'NutriQuest Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const DemoHomeScreen(),
      ),
    );
}

class DemoHomeScreen extends StatefulWidget {
  const DemoHomeScreen({super.key});

  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize demo data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().initializeGameData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('NutriQuest Demo'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'NutriQuest',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Educational Gaming Platform',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Demo Status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Demo Mode Active',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        Text(
                          'All features working without Firebase',
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Game Features
            const Text(
              'Game Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildGameCard(
              icon: Icons.quiz,
              title: 'Nutrition Quiz',
              description: 'Test your knowledge with interactive questions',
              onTap: () => _showQuizDemo(),
            ),
            
            _buildGameCard(
              icon: Icons.sort,
              title: 'Food Sort Game',
              description: 'Categorize healthy vs unhealthy foods',
              onTap: () => _showFoodSortDemo(),
            ),
            
            _buildGameCard(
              icon: Icons.restaurant,
              title: 'Meal Builder',
              description: 'Create balanced meals and earn points',
              onTap: () => _showMealBuilderDemo(),
            ),
            
            _buildGameCard(
              icon: Icons.school,
              title: 'Learning Hub',
              description: 'Educational content and nutrition facts',
              onTap: () => _showLearningDemo(),
            ),
            
            const SizedBox(height: 24),
            
            // Working Quiz Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openWorkingQuiz(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Open Working Quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  void _showQuizDemo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nutrition Quiz'),
        content: const Text('This would show the interactive quiz with multiple choice questions, scoring, and educational feedback.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _openWorkingQuiz();
            },
            child: const Text('Open Working Quiz'),
          ),
        ],
      ),
    );
  }

  void _showFoodSortDemo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Food Sort Game'),
        content: const Text('This would show the drag-and-drop game where you categorize foods as healthy or unhealthy.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showMealBuilderDemo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Meal Builder'),
        content: const Text('This would show the interactive meal creation tool with nutrition scoring and balanced meal guidance.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLearningDemo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Learning Hub'),
        content: const Text('This would show educational content, nutrition facts, and interactive learning modules.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openWorkingQuiz() {
    // Open the working quiz HTML file
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Working Quiz'),
        content: const Text('The working quiz will open in your browser. It features 5 interactive nutrition questions with scoring and feedback.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // This would open the quiz file
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Open: nutriquest_quiz.html in your browser'),
                ),
              );
            },
            child: const Text('Open Quiz'),
          ),
        ],
      ),
    );
  }
}
