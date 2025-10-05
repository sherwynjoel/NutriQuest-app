import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/game_models.dart';

class GameProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<QuizQuestion> _quizQuestions = [];
  List<FoodItem> _foodItems = [];
  List<MealComponent> _mealComponents = [];
  List<LeaderboardEntry> _leaderboard = [];
  
  int _currentScore = 0;
  int _currentStreak = 0;
  bool _isLoading = false;

  // Getters
  List<QuizQuestion> get quizQuestions => _quizQuestions;
  List<FoodItem> get foodItems => _foodItems;
  List<MealComponent> get mealComponents => _mealComponents;
  List<LeaderboardEntry> get leaderboard => _leaderboard;
  int get currentScore => _currentScore;
  int get currentStreak => _currentStreak;
  bool get isLoading => _isLoading;

  // Initialize game data
  Future<void> initializeGameData() async {
    _setLoading(true);
    
    try {
      await Future.wait([
        _loadQuizQuestions(),
        _loadFoodItems(),
        _loadMealComponents(),
        _loadLeaderboard(),
      ]);
    } catch (e) {
      print('Error initializing game data: $e');
    }
    
    _setLoading(false);
  }

  Future<void> _loadQuizQuestions() async {
    try {
      // Sample quiz questions - in production, load from Firestore
      _quizQuestions = [
        QuizQuestion(
          id: '1',
          question: 'Which fruit is highest in vitamin C?',
          options: ['Apple', 'Orange', 'Banana', 'Grape'],
          correctAnswer: 1,
          explanation: 'Oranges are rich in vitamin C, providing about 70mg per medium fruit.',
          category: 'Nutrition',
          difficulty: 'Easy',
        ),
        QuizQuestion(
          id: '2',
          question: 'How many servings of vegetables should you eat daily?',
          options: ['2-3', '3-4', '5-6', '7-8'],
          correctAnswer: 2,
          explanation: 'The recommended daily intake is 5-6 servings of vegetables.',
          category: 'Nutrition',
          difficulty: 'Medium',
        ),
        QuizQuestion(
          id: '3',
          question: 'Which is a complete protein source?',
          options: ['Rice', 'Beans', 'Quinoa', 'Lettuce'],
          correctAnswer: 2,
          explanation: 'Quinoa is a complete protein containing all essential amino acids.',
          category: 'Nutrition',
          difficulty: 'Hard',
        ),
      ];
    } catch (e) {
      print('Error loading quiz questions: $e');
      _quizQuestions = [];
    }
  }

  Future<void> _loadFoodItems() async {
    try {
      // Sample food items for sorting game
      _foodItems = [
        FoodItem(
          id: '1',
          name: 'Apple',
          imageUrl: 'assets/images/foods/apple.png',
          category: FoodCategory.healthy,
          nutritionFacts: 'Rich in fiber and vitamin C',
        ),
        FoodItem(
          id: '2',
          name: 'Pizza',
          imageUrl: 'assets/images/foods/pizza.png',
          category: FoodCategory.unhealthy,
          nutritionFacts: 'High in calories and sodium',
        ),
        FoodItem(
          id: '3',
          name: 'Broccoli',
          imageUrl: 'assets/images/foods/broccoli.png',
          category: FoodCategory.healthy,
          nutritionFacts: 'Packed with vitamins K and C',
        ),
        FoodItem(
          id: '4',
          name: 'Candy',
          imageUrl: 'assets/images/foods/candy.png',
          category: FoodCategory.unhealthy,
          nutritionFacts: 'High in sugar with no nutritional value',
        ),
      ];
    } catch (e) {
      print('Error loading food items: $e');
      _foodItems = [];
    }
  }

  Future<void> _loadMealComponents() async {
    try {
      // Sample meal components for meal builder
      _mealComponents = [
        MealComponent(
          id: '1',
          name: 'Grilled Chicken',
          imageUrl: 'assets/images/meals/chicken.png',
          category: MealCategory.protein,
          nutritionValue: 25,
        ),
        MealComponent(
          id: '2',
          name: 'Brown Rice',
          imageUrl: 'assets/images/meals/rice.png',
          category: MealCategory.carbohydrate,
          nutritionValue: 20,
        ),
        MealComponent(
          id: '3',
          name: 'Mixed Vegetables',
          imageUrl: 'assets/images/meals/vegetables.png',
          category: MealCategory.vegetable,
          nutritionValue: 15,
        ),
      ];
    } catch (e) {
      print('Error loading meal components: $e');
      _mealComponents = [];
    }
  }

  Future<void> _loadLeaderboard() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .orderBy('totalXP', descending: true)
          .limit(10)
          .get();

      _leaderboard = snapshot.docs.map((doc) {
        final data = doc.data();
        return LeaderboardEntry(
          userId: doc.id,
          displayName: data['displayName'] ?? 'Anonymous',
          photoURL: data['photoURL'],
          totalXP: data['totalXP'] ?? 0,
          level: data['level'] ?? 1,
        );
      }).toList();
    } catch (e) {
      print('Error loading leaderboard: $e');
    }
  }

  Future<void> loadLeaderboard() async {
    await _loadLeaderboard();
    notifyListeners();
  }

  // Quiz game methods
  Future<bool> submitQuizAnswer(String questionId, int selectedAnswer) async {
    final question = _quizQuestions.firstWhere((q) => q.id == questionId);
    final isCorrect = question.correctAnswer == selectedAnswer;
    
    if (isCorrect) {
      _currentScore += 10;
      _currentStreak++;
    } else {
      _currentStreak = 0;
    }
    
    notifyListeners();
    return isCorrect;
  }

  // Food sort game methods
  Future<bool> sortFoodItem(String foodId, FoodCategory selectedCategory) async {
    final food = _foodItems.firstWhere((f) => f.id == foodId);
    final isCorrect = food.category == selectedCategory;
    
    if (isCorrect) {
      _currentScore += 5;
      _currentStreak++;
    } else {
      _currentStreak = 0;
    }
    
    notifyListeners();
    return isCorrect;
  }

  // Meal builder methods
  Future<int> calculateMealScore(List<String> selectedComponents) async {
    var score = 0;
    var proteinCount = 0;
    var carbCount = 0;
    var vegetableCount = 0;

    for (final componentId in selectedComponents) {
      final component = _mealComponents.firstWhere((c) => c.id == componentId);
      score += component.nutritionValue;
      
      switch (component.category) {
        case MealCategory.protein:
          proteinCount++;
          break;
        case MealCategory.carbohydrate:
          carbCount++;
          break;
        case MealCategory.vegetable:
          vegetableCount++;
          break;
        case MealCategory.fruit:
          // Fruits are also considered healthy components
          vegetableCount++;
          break;
        case MealCategory.dairy:
          // Dairy can be considered protein
          proteinCount++;
          break;
      }
    }

    // Bonus points for balanced meal
    if (proteinCount > 0 && carbCount > 0 && vegetableCount > 0) {
      score += 20; // Balanced meal bonus
    }

    _currentScore += score;
    _currentStreak++;
    notifyListeners();
    
    return score;
  }

  // Update user progress
  Future<void> updateUserProgress(int xpGained) async {
    if (_auth.currentUser == null) return;

    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'totalXP': FieldValue.increment(xpGained),
        'lastActive': FieldValue.serverTimestamp(),
      });
      
      // Reload leaderboard
      await _loadLeaderboard();
    } catch (e) {
      print('Error updating user progress: $e');
    }
  }

  void resetGame() {
    _currentScore = 0;
    _currentStreak = 0;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
