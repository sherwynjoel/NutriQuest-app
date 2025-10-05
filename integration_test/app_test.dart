import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nutriquest_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('NutriQuest Integration Tests', () {
    testWidgets('Complete user journey test', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Test splash screen
      expect(find.text('NutriQuest'), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test onboarding flow
      if (find.text('Get Started').evaluate().isNotEmpty) {
        await tester.tap(find.text('Get Started'));
        await tester.pumpAndSettle();
      }

      // Test home screen
      expect(find.text('Play Games'), findsOneWidget);
      expect(find.text('Learn'), findsOneWidget);
      expect(find.text('Leaderboard'), findsOneWidget);

      // Test navigation to quiz
      if (find.text('Quiz Game').evaluate().isNotEmpty) {
        await tester.tap(find.text('Quiz Game'));
        await tester.pumpAndSettle();
        
        // Test quiz functionality
        if (find.text('Start Quiz').evaluate().isNotEmpty) {
          await tester.tap(find.text('Start Quiz'));
          await tester.pumpAndSettle();
        }
      }

      // Test navigation to food sort
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      
      if (find.text('Food Sort').evaluate().isNotEmpty) {
        await tester.tap(find.text('Food Sort'));
        await tester.pumpAndSettle();
      }

      // Test navigation to meal builder
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      
      if (find.text('Meal Builder').evaluate().isNotEmpty) {
        await tester.tap(find.text('Meal Builder'));
        await tester.pumpAndSettle();
      }

      // Test navigation to learning hub
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      
      if (find.text('Learn').evaluate().isNotEmpty) {
        await tester.tap(find.text('Learn'));
        await tester.pumpAndSettle();
      }

      // Test navigation to leaderboard
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      
      if (find.text('Leaderboard').evaluate().isNotEmpty) {
        await tester.tap(find.text('Leaderboard'));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Game functionality test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test quiz game
      if (find.text('Quiz Game').evaluate().isNotEmpty) {
        await tester.tap(find.text('Quiz Game'));
        await tester.pumpAndSettle();
        
        // Test quiz questions
        if (find.text('Start Quiz').evaluate().isNotEmpty) {
          await tester.tap(find.text('Start Quiz'));
          await tester.pumpAndSettle();
          
          // Answer questions if available
          for (int i = 0; i < 3; i++) {
            if (find.text('Option A').evaluate().isNotEmpty) {
              await tester.tap(find.text('Option A'));
              await tester.pumpAndSettle();
            }
          }
        }
      }
    });
  });
}
