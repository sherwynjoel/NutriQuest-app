import 'package:flutter/material.dart';

class AssetHelper {
  static const String _baseImagePath = 'assets/images/';
  static const String _baseIconPath = 'assets/icons/';
  static const String _baseAnimationPath = 'assets/animations/';

  // Image paths
  static const String appLogo = '${_baseImagePath}app_logo.png';
  static const String foodApple = '${_baseImagePath}foods/apple.png';
  static const String foodPizza = '${_baseImagePath}foods/pizza.png';
  static const String foodBroccoli = '${_baseImagePath}foods/broccoli.png';
  static const String foodCandy = '${_baseImagePath}foods/candy.png';
  
  // Meal component images
  static const String mealChicken = '${_baseImagePath}meals/chicken.png';
  static const String mealRice = '${_baseImagePath}meals/rice.png';
  static const String mealVegetables = '${_baseImagePath}meals/vegetables.png';

  // Icon paths
  static const String badgeFirstSteps = '${_baseIconPath}badges/first_steps.png';
  static const String badgeQuizMaster = '${_baseIconPath}badges/quiz_master.png';
  static const String badgeHealthyEater = '${_baseIconPath}badges/healthy_eater.png';
  
  // Animation paths
  static const String loadingAnimation = '${_baseAnimationPath}loading.json';
  static const String successAnimation = '${_baseAnimationPath}success.json';
  static const String celebrationAnimation = '${_baseAnimationPath}celebration.json';

  // Safe image widget with error handling
  static Widget safeImage({
    required String imagePath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) => Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => errorWidget ?? _defaultErrorWidget(),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return placeholder ?? _defaultPlaceholder();
      },
    );

  // Safe network image widget with error handling
  static Widget safeNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) => Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => errorWidget ?? _defaultErrorWidget(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? _defaultPlaceholder();
      },
    );

  static Widget _defaultErrorWidget() => Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.error_outline,
        color: Colors.grey,
        size: 48,
      ),
    );

  static Widget _defaultPlaceholder() => Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
}
