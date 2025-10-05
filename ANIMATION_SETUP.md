# Animation Setup Guide for NutriQuest

## 🎬 Lottie Animation Assets

### Available Animations

1. **Loading Animation** (`assets/animations/loading.json`)
   - Spinning circle with fade effect
   - Perfect for loading screens and progress indicators
   - Duration: 3 seconds (90 frames at 30fps)

2. **Success Animation** (`assets/animations/success.json`)
   - Green circle with white checkmark
   - Ideal for correct answers and achievements
   - Duration: 2 seconds (60 frames at 30fps)

3. **Celebration Animation** (`assets/animations/celebration.json`)
   - Confetti and stars animation
   - Perfect for level completion and major achievements
   - Duration: 4 seconds (120 frames at 30fps)

### Usage in Flutter

```dart
import 'package:lottie/lottie.dart';

// Loading animation
Lottie.asset(
  'assets/animations/loading.json',
  width: 100,
  height: 100,
)

// Success animation
Lottie.asset(
  'assets/animations/success.json',
  width: 80,
  height: 80,
)

// Celebration animation
Lottie.asset(
  'assets/animations/celebration.json',
  width: 200,
  height: 200,
)
```

### Integration Examples

#### 1. Loading Screen
```dart
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            width: 100,
            height: 100,
          ),
          SizedBox(height: 20),
          Text('Loading...', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
```

#### 2. Quiz Success
```dart
class QuizSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/success.json',
            width: 80,
            height: 80,
          ),
          SizedBox(height: 16),
          Text('Correct!', style: TextStyle(fontSize: 24, color: Colors.green)),
        ],
      ),
    );
  }
}
```

#### 3. Level Completion
```dart
class LevelCompletion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/celebration.json',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text('Level Complete!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Text('+100 XP', style: TextStyle(fontSize: 20, color: Colors.orange)),
        ],
      ),
    );
  }
}
```

### Customization

#### Animation Controls
```dart
Lottie.asset(
  'assets/animations/loading.json',
  width: 100,
  height: 100,
  repeat: true,        // Loop the animation
  animate: true,       // Auto-play
  frameRate: FrameRate(30), // Custom frame rate
)
```

#### Animation Listeners
```dart
Lottie.asset(
  'assets/animations/success.json',
  width: 80,
  height: 80,
  onLoaded: (composition) {
    // Animation loaded
  },
  onAnimationEnd: () {
    // Animation finished
  },
)
```

### Performance Tips

1. **Preload Animations**: Load animations during app startup
2. **Dispose Properly**: Always dispose of animation controllers
3. **Optimize Size**: Use appropriate dimensions for your use case
4. **Cache Animations**: Consider caching for frequently used animations

### Troubleshooting

- **Animation not playing**: Check file path and pubspec.yaml assets
- **Performance issues**: Reduce animation complexity or size
- **Build errors**: Ensure lottie package is added to pubspec.yaml

---
**Your NutriQuest app now has beautiful animations! 🎉**
