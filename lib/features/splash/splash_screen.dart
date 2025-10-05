import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Animation
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.restaurant_menu,
                size: 100,
                color: AppTheme.primaryGreen,
              ),
            )
                .animate()
                .scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                )
                .then()
                .shimmer(
                  duration: 1000.ms,
                  color: Colors.white.withOpacity(0.5),
                ),
            
            const SizedBox(height: 40),
            
            // App Name
            Text(
              'NutriQuest',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .fadeIn(
                  delay: 500.ms,
                  duration: 800.ms,
                )
                .slideY(
                  begin: 0.3,
                  end: 0,
                  curve: Curves.easeOut,
                ),
            
            const SizedBox(height: 16),
            
            // Tagline
            Text(
              'Learn. Play. Eat Healthy.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            )
                .animate()
                .fadeIn(
                  delay: 800.ms,
                  duration: 800.ms,
                )
                .slideY(
                  begin: 0.3,
                  end: 0,
                  curve: Curves.easeOut,
                ),
            
            const SizedBox(height: 60),
            
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                .animate()
                .fadeIn(
                  delay: 1200.ms,
                  duration: 600.ms,
                ),
          ],
        ),
      ),
    );
}
