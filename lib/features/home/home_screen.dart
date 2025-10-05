import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/providers/user_provider.dart';
import '../../core/providers/game_provider.dart';
import '../widgets/game_card.dart';
import '../widgets/stats_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUserProfile();
      context.read<GameProvider>().initializeGameData();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('NutriQuest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () => context.go('/leaderboard'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: Consumer2<UserProvider, GameProvider>(
        builder: (context, userProvider, gameProvider, child) {
          if (userProvider.isLoading || gameProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                if (userProvider.userProfile != null)
                  _buildWelcomeSection(userProvider.userProfile),
                
                const SizedBox(height: 24),
                
                // Stats section
                _buildStatsSection(userProvider.userProfile),
                
                const SizedBox(height: 24),
                
                // Game modules
                Text(
                  'Play & Learn',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                _buildGameModules(),
                
                const SizedBox(height: 24),
                
                // Quick actions
                _buildQuickActions(),
              ],
            ),
          );
        },
      ),
    );

  Widget _buildWelcomeSection(userProfile) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.secondaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${userProfile.displayName.split(' ').first}!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Ready to learn about healthy eating?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              _buildStatItem(
                'Level ${userProfile.level}',
                Icons.star,
                Colors.white,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                '${userProfile.totalXP} XP',
                Icons.local_fire_department,
                Colors.white,
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                '${userProfile.streak} day streak',
                Icons.whatshot,
                Colors.white,
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOut);

  Widget _buildStatItem(String text, IconData icon, Color color) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );

  Widget _buildStatsSection(userProfile) {
    if (userProfile == null) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'Total XP',
            value: '${userProfile.totalXP}',
            icon: Icons.local_fire_department,
            color: AppTheme.accentOrange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            title: 'Level',
            value: '${userProfile.level}',
            icon: Icons.star,
            color: AppTheme.accentYellow,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            title: 'Streak',
            value: '${userProfile.streak}',
            icon: Icons.whatshot,
            color: AppTheme.errorRed,
          ),
        ),
      ],
    );
  }

  Widget _buildGameModules() => Column(
      children: [
        GameCard(
          title: 'Nutrition Quiz',
          description: 'Test your knowledge with fun questions',
          icon: Icons.quiz,
          color: AppTheme.primaryGreen,
          onTap: () => context.go('/quiz'),
        ),
        
        const SizedBox(height: 12),
        
        GameCard(
          title: 'Food Sort',
          description: 'Sort healthy vs unhealthy foods',
          icon: Icons.sort,
          color: AppTheme.accentOrange,
          onTap: () => context.go('/food-sort'),
        ),
        
        const SizedBox(height: 12),
        
        GameCard(
          title: 'Meal Builder',
          description: 'Create balanced meals and earn points',
          icon: Icons.restaurant,
          color: AppTheme.accentYellow,
          onTap: () => context.go('/meal-builder'),
        ),
      ],
    );

  Widget _buildQuickActions() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Learn',
                Icons.school,
                AppTheme.primaryGreen,
                () => context.go('/learn'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
                'Leaderboard',
                Icons.leaderboard,
                AppTheme.accentOrange,
                () => context.go('/leaderboard'),
              ),
            ),
          ],
        ),
      ],
    );

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
}
