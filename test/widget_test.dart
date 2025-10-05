import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nutriquest_app/core/providers/auth_provider.dart';
import 'package:nutriquest_app/core/providers/game_provider.dart';
import 'package:nutriquest_app/core/providers/user_provider.dart';
import 'package:nutriquest_app/features/home/home_screen.dart';

void main() {
  group('NutriQuest Widget Tests', () {
    testWidgets('Home screen displays correctly', (WidgetTester tester) async {
      // Create mock providers
      final authProvider = AuthProvider();
      final gameProvider = GameProvider();
      final userProvider = UserProvider();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => authProvider),
            ChangeNotifierProvider(create: (_) => gameProvider),
            ChangeNotifierProvider(create: (_) => userProvider),
          ],
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify home screen elements
      expect(find.text('NutriQuest'), findsOneWidget);
      expect(find.text('Play Games'), findsOneWidget);
      expect(find.text('Learn'), findsOneWidget);
      expect(find.text('Leaderboard'), findsOneWidget);
    });

    testWidgets('Game cards are displayed', (WidgetTester tester) async {
      final gameProvider = GameProvider();
      
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => gameProvider,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify game cards are present
      expect(find.text('Quiz Game'), findsOneWidget);
      expect(find.text('Food Sort'), findsOneWidget);
      expect(find.text('Meal Builder'), findsOneWidget);
    });
  });
}
