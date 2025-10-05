# NutriQuest - Educational Gaming Platform

A fun, game-based Flutter app where students learn about healthy eating habits and nutrition while playing interactive challenges. Compete with friends while learning about balanced diets and food sustainability.

## 🎯 Project Overview

NutriQuest is an educational gaming platform designed to make learning about nutrition engaging and fun. The app combines gamification with educational content to help students develop healthy eating habits through interactive games, quizzes, and challenges.

## ✨ Features

### Core Features
- **User Authentication**: Google Sign-In using Firebase Authentication
- **Interactive Game Modules**:
  - Nutrition Quiz: Fun multiple-choice challenges
  - Food Sorting Game: Drag-and-drop healthy vs unhealthy foods
  - Meal Builder: Design balanced meals and earn points
- **Gamification System**: XP points, badges, streaks, and leaderboards
- **Learning Hub**: Nutrition facts and educational content
- **Social Features**: Challenge friends and compete on leaderboards

### Google Cloud Integration
- **Firestore**: Store user profiles and game data
- **Cloud Functions**: Scoring logic and leaderboard updates
- **Cloud Storage**: Images and game assets
- **Firebase Authentication**: Secure user management

## 🛠️ Technical Stack

- **Frontend**: Flutter 3.x
- **Backend**: Firebase + Google Cloud Functions
- **Database**: Firestore (NoSQL)
- **Authentication**: Google Sign-In
- **State Management**: Provider
- **Navigation**: GoRouter
- **UI/UX**: Material Design 3 with custom theming

## 📱 Screens

1. **Splash Screen**: Animated app logo and loading
2. **Onboarding**: Interactive carousel explaining app features
3. **Authentication**: Google Sign-In integration
4. **Home Dashboard**: Game modules, stats, and quick actions
5. **Quiz Game**: Multiple-choice nutrition questions with explanations
6. **Food Sort Game**: Categorize healthy vs unhealthy foods
7. **Meal Builder**: Create balanced meals with scoring system
8. **Learning Hub**: Nutrition facts and educational content
9. **Leaderboard**: Global and friend-based rankings
10. **Profile**: User stats, badges, achievements, and settings

## 🎨 Design System

- **Theme**: Vibrant, playful colors (greens, oranges, yellows)
- **Style**: Flat design with minimal text and icon-focused UI
- **Typography**: Nunito font family for child-friendly readability
- **Layout**: Card-based UI with gamified feedback animations
- **Accessibility**: Large touch targets and child-friendly visuals

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Firebase project setup
- Google Cloud Platform account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/nutriquest-app.git
   cd nutriquest-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Authentication (Google Sign-In)
   - Enable Firestore Database
   - Enable Cloud Storage
   - Download and configure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

4. **Update Firebase Configuration**
   - Update `lib/firebase_options.dart` with your Firebase project credentials

5. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── models/          # Data models
│   ├── providers/       # State management
│   ├── router/          # Navigation
│   └── theme/           # App theming
├── features/
│   ├── auth/           # Authentication screens
│   ├── games/          # Game modules
│   ├── home/           # Home dashboard
│   ├── learn/          # Learning content
│   ├── leaderboard/    # Rankings
│   ├── profile/        # User profile
│   └── widgets/        # Reusable components
└── main.dart           # App entry point
```

## 🎮 Game Mechanics

### Scoring System
- **Quiz Questions**: 10 XP per correct answer
- **Food Sorting**: 5 XP per correct sort
- **Meal Building**: Variable XP based on nutrition value + balanced meal bonus
- **Streaks**: Bonus multipliers for consecutive correct answers

### Progression
- **Levels**: Unlock new content and features
- **Badges**: Achieve specific milestones
- **Achievements**: Long-term goals and challenges
- **Leaderboards**: Compete with friends and global players

## 🔧 Development

### Adding New Game Types
1. Create new game model in `core/models/game_models.dart`
2. Add game logic to `GameProvider`
3. Create game screen in `features/games/`
4. Update navigation in `AppRouter`

### Customizing Themes
- Modify colors in `core/theme/app_theme.dart`
- Update typography and component styles
- Add new animations and transitions

## 📊 Analytics & Monitoring

- **Firebase Analytics**: Track user engagement and game performance
- **Crashlytics**: Monitor app stability
- **Performance Monitoring**: Optimize app performance

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase/Google Cloud for backend services
- Material Design for UI guidelines
- Open source community for inspiration and resources


---

