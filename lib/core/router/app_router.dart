import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/auth_screen.dart';
import '../../features/games/food_sort/food_sort_screen.dart';
import '../../features/games/meal_builder/meal_builder_screen.dart';
import '../../features/games/quiz/quiz_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/leaderboard/leaderboard_screen.dart';
import '../../features/learn/learn_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../providers/auth_provider.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      // If user is not authenticated and not on auth/splash/onboarding screens
      if (!authProvider.isAuthenticated) {
        if (state.uri.toString() == '/splash' || 
            state.uri.toString() == '/onboarding' || 
            state.uri.toString() == '/auth') {
          return null; // Allow navigation to these screens
        }
        return '/auth'; // Redirect to auth
      }
      
      // If user is authenticated and on auth screen, redirect to home
      if (authProvider.isAuthenticated && state.uri.toString() == '/auth') {
        return '/home';
      }
      
      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        path: '/food-sort',
        builder: (context, state) => const FoodSortScreen(),
      ),
      GoRoute(
        path: '/meal-builder',
        builder: (context, state) => const MealBuilderScreen(),
      ),
      GoRoute(
        path: '/learn',
        builder: (context, state) => const LearnScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
