import 'package:flutter_test/flutter_test.dart';
import 'package:nutriquest_app/core/providers/game_provider.dart';
import 'package:nutriquest_app/core/models/game_models.dart';

void main() {
  group('GameProvider Tests', () {
    late GameProvider gameProvider;

    setUp(() {
      gameProvider = GameProvider();
    });

    test('initial state is correct', () {
      expect(gameProvider.quizQuestions, isEmpty);
      expect(gameProvider.foodItems, isEmpty);
      expect(gameProvider.mealComponents, isEmpty);
      expect(gameProvider.leaderboard, isEmpty);
      expect(gameProvider.currentScore, 0);
      expect(gameProvider.isLoading, false);
    });

    test('quiz questions model is correct', () {
      final mockQuestion = QuizQuestion(
        id: '1',
        question: 'What is the main nutrient in apples?',
        options: ['Vitamin C', 'Protein', 'Fat', 'Sugar'],
        correctAnswer: 0,
        explanation: 'Apples are rich in Vitamin C',
        difficulty: 'easy',
        category: 'Nutrition',
      );

      expect(mockQuestion.id, '1');
      expect(mockQuestion.question, 'What is the main nutrient in apples?');
      expect(mockQuestion.options.length, 4);
      expect(mockQuestion.correctAnswer, 0);
    });

    test('food item model is correct', () {
      final mockFood = FoodItem(
        id: '1',
        name: 'Apple',
        category: FoodCategory.healthy,
        imageUrl: 'apple.png',
        nutritionFacts: 'Rich in Vitamin C and fiber',
      );

      expect(mockFood.id, '1');
      expect(mockFood.name, 'Apple');
      expect(mockFood.category, FoodCategory.healthy);
      expect(mockFood.nutritionFacts, 'Rich in Vitamin C and fiber');
    });

    test('meal component model is correct', () {
      final mockComponent = MealComponent(
        id: '1',
        name: 'Chicken Breast',
        category: MealCategory.protein,
        imageUrl: 'chicken.png',
        nutritionValue: 165,
      );

      expect(mockComponent.id, '1');
      expect(mockComponent.name, 'Chicken Breast');
      expect(mockComponent.category, MealCategory.protein);
      expect(mockComponent.nutritionValue, 165);
    });

    test('leaderboard entry model is correct', () {
      final mockEntry = LeaderboardEntry(
        userId: 'user1',
        displayName: 'Player 1',
        totalXP: 1000,
        level: 5,
        photoURL: 'avatar1.png',
      );

      expect(mockEntry.userId, 'user1');
      expect(mockEntry.displayName, 'Player 1');
      expect(mockEntry.totalXP, 1000);
      expect(mockEntry.level, 5);
    });
  });
}
