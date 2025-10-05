import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              
              // Logo and title
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 60,
                      color: AppTheme.primaryGreen,
                    ),
                  )
                      .animate()
                      .scale(
                        duration: 600.ms,
                        curve: Curves.elasticOut,
                      ),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    'Welcome to NutriQuest',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(
                        delay: 200.ms,
                        duration: 600.ms,
                      )
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        curve: Curves.easeOut,
                      ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Learn about healthy eating through fun games and challenges',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textLight,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(
                        delay: 400.ms,
                        duration: 600.ms,
                      )
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        curve: Curves.easeOut,
                      ),
                ],
              ),
              
              const Spacer(),
              
              // Sign in button
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) => SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              final success = await authProvider.signInWithGoogle();
                              if (success && mounted) {
                                context.go('/home');
                              } else if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      authProvider.errorMessage ?? 'Sign in failed',
                                    ),
                                    backgroundColor: AppTheme.errorRed,
                                  ),
                                );
                              }
                            },
                      icon: authProvider.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        authProvider.isLoading ? 'Signing in...' : 'Continue with Google',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(
                        delay: 600.ms,
                        duration: 600.ms,
                      )
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        curve: Curves.easeOut,
                      ),
              ),
              
              const SizedBox(height: 24),
              
              // Terms and privacy
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textLight,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(
                    delay: 800.ms,
                    duration: 600.ms,
                  ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
}
