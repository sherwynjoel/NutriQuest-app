import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/providers/game_provider.dart';
import '../../core/models/game_models.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().loadLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Leaderboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameProvider>().loadLeaderboard();
            },
          ),
        ],
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (gameProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gameProvider.leaderboard.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.leaderboard,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No leaderboard data available',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                
                const SizedBox(height: 24),
                
                // Top 3 players
                _buildTopPlayers(gameProvider.leaderboard),
                
                const SizedBox(height: 24),
                
                // Full leaderboard
                _buildFullLeaderboard(gameProvider.leaderboard),
              ],
            ),
          );
        },
      ),
    );

  Widget _buildHeader() => Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.emoji_events,
              size: 48,
              color: AppTheme.accentYellow,
            ),
            const SizedBox(height: 16),
            Text(
              'Global Leaderboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Compete with players worldwide and climb the ranks!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOut);

  Widget _buildTopPlayers(List<LeaderboardEntry> leaderboard) {
    if (leaderboard.length < 3) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Players',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // 2nd place
            if (leaderboard.length > 1)
              Expanded(
                child: _buildTopPlayerCard(leaderboard[1], 2, AppTheme.textLight),
              ),
            
            if (leaderboard.length > 1) const SizedBox(width: 12),
            
            // 1st place
            Expanded(
              child: _buildTopPlayerCard(leaderboard[0], 1, AppTheme.accentYellow),
            ),
            
            const SizedBox(width: 12),
            
            // 3rd place
            if (leaderboard.length > 2)
              Expanded(
                child: _buildTopPlayerCard(leaderboard[2], 3, AppTheme.accentOrange),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopPlayerCard(LeaderboardEntry entry, int position, Color color) => Card(
      elevation: position == 1 ? 8 : 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Position
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$position',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
              child: entry.photoURL != null
                  ? ClipOval(
                      child: Image.network(
                        entry.photoURL!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 30,
                            color: AppTheme.primaryGreen,
                          ),
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 30,
                      color: AppTheme.primaryGreen,
                    ),
            ),
            
            const SizedBox(height: 12),
            
            // Name
            Text(
              entry.displayName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 4),
            
            // XP
            Text(
              '${entry.totalXP} XP',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Level
            Text(
              'Level ${entry.level}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
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

  Widget _buildFullLeaderboard(List<LeaderboardEntry> leaderboard) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Players',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 16),
        ...leaderboard.asMap().entries.map((entry) {
          final index = entry.key;
          final player = entry.value;
          return _buildLeaderboardItem(player, index + 1);
        }),
      ],
    );

  Widget _buildLeaderboardItem(LeaderboardEntry entry, int position) => Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Position
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _getPositionColor(position),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$position',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                child: entry.photoURL != null
                    ? ClipOval(
                        child: Image.network(
                          entry.photoURL!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 20,
                              color: AppTheme.primaryGreen,
                            ),
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 20,
                        color: AppTheme.primaryGreen,
                      ),
              ),
              
              const SizedBox(width: 16),
              
              // Name and level
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.displayName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    Text(
                      'Level ${entry.level}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              
              // XP
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${entry.totalXP}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  Text(
                    'XP',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.3, end: 0, curve: Curves.easeOut);

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return AppTheme.accentYellow;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return AppTheme.accentOrange;
      default:
        return AppTheme.primaryGreen;
    }
  }
}
