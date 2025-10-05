// Quiz Models
class QuizQuestion {

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.category,
    required this.difficulty,
  });
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String category;
  final String difficulty;
}

// Food Sort Models
enum FoodCategory { healthy, unhealthy }

class FoodItem {

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.nutritionFacts,
  });
  final String id;
  final String name;
  final String imageUrl;
  final FoodCategory category;
  final String nutritionFacts;
}

// Meal Builder Models
enum MealCategory { protein, carbohydrate, vegetable, fruit, dairy }

class MealComponent {

  MealComponent({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.nutritionValue,
  });
  final String id;
  final String name;
  final String imageUrl;
  final MealCategory category;
  final int nutritionValue;
}

// Leaderboard Models
class LeaderboardEntry {

  LeaderboardEntry({
    required this.userId,
    required this.displayName,
    required this.totalXP, required this.level, this.photoURL,
  });
  final String userId;
  final String displayName;
  final String? photoURL;
  final int totalXP;
  final int level;
}
