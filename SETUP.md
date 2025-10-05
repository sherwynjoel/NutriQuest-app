# NutriQuest Setup Guide

This guide will help you set up the NutriQuest Flutter app for development and deployment.

## 🚀 Quick Start

### 1. Prerequisites

- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Version 3.0.0 or higher  
- **Android Studio** or **VS Code** with Flutter extensions
- **Firebase CLI**: `npm install -g firebase-tools`
- **Google Cloud Platform** account

### 2. Clone and Setup

```bash
# Clone the repository
git clone https://github.com/your-username/nutriquest-app.git
cd nutriquest-app

# Install Flutter dependencies
flutter pub get

# Install Firebase Functions dependencies
cd functions
npm install
cd ..
```

### 3. Firebase Project Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Name your project: `nutriquest-app`
4. Enable Google Analytics (optional)
5. Create the project

#### Enable Required Services
1. **Authentication**:
   - Go to Authentication > Sign-in method
   - Enable "Google" provider
   - Add your domain for web

2. **Firestore Database**:
   - Go to Firestore Database
   - Click "Create database"
   - Start in test mode (for development)

3. **Cloud Storage**:
   - Go to Storage
   - Click "Get started"
   - Start in test mode

#### Download Configuration Files
1. **Android**: Download `google-services.json`
   - Place in `android/app/` directory

2. **iOS**: Download `GoogleService-Info.plist`
   - Place in `ios/Runner/` directory

3. **Web**: Copy Firebase config
   - Update `lib/firebase_options.dart` with your config

### 4. Update Firebase Configuration

Update `lib/firebase_options.dart` with your Firebase project credentials:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'your-web-api-key',
  appId: 'your-web-app-id',
  messagingSenderId: 'your-sender-id',
  projectId: 'your-project-id',
  authDomain: 'your-project-id.firebaseapp.com',
  storageBucket: 'your-project-id.appspot.com',
);
```

### 5. Run the App

```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For Web
flutter run -d web
```

## 🔧 Development Setup

### Project Structure
```
nutriquest-app/
├── lib/
│   ├── core/           # Core functionality
│   ├── features/       # Feature modules
│   └── main.dart       # App entry point
├── assets/             # Images, fonts, animations
├── functions/          # Cloud Functions
└── android/ios/web/    # Platform-specific code
```

### Key Dependencies
- `firebase_core`: Firebase initialization
- `firebase_auth`: User authentication
- `cloud_firestore`: Database operations
- `google_sign_in`: Google authentication
- `provider`: State management
- `go_router`: Navigation
- `flutter_animate`: Animations

### Development Workflow
1. **Feature Development**: Create new features in `lib/features/`
2. **State Management**: Use Provider pattern in `lib/core/providers/`
3. **UI Components**: Create reusable widgets in `lib/features/widgets/`
4. **Testing**: Add tests in `test/` directory

## 🚀 Deployment

### Android Deployment
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS Deployment
```bash
# Build iOS app
flutter build ios --release

# Archive and upload to App Store Connect
# Use Xcode for final deployment
```

### Web Deployment
```bash
# Build web app
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

### Cloud Functions Deployment
```bash
# Deploy functions
firebase deploy --only functions

# Deploy everything
firebase deploy
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Firebase Emulators (Local Development)
```bash
# Start emulators
firebase emulators:start

# Run tests against emulators
flutter test --dart-define=FIREBASE_AUTH_EMULATOR_HOST=localhost:9099
```

## 📱 Platform-Specific Setup

### Android Setup
1. **Minimum SDK**: API level 21 (Android 5.0)
2. **Target SDK**: API level 33 (Android 13)
3. **Permissions**: Internet, Camera (for profile photos)

### iOS Setup
1. **Minimum iOS**: 11.0
2. **Target iOS**: 16.0
3. **Permissions**: Camera, Photo Library

### Web Setup
1. **Supported Browsers**: Chrome, Firefox, Safari, Edge
2. **PWA Support**: Service worker for offline functionality

## 🔐 Security Configuration

### Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Leaderboard is read-only for authenticated users
    match /leaderboard/{userId} {
      allow read: if request.auth != null;
    }
  }
}
```

### Storage Security Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 🐛 Troubleshooting

### Common Issues

1. **Firebase not initialized**:
   - Check `firebase_options.dart` configuration
   - Ensure Firebase project is properly set up

2. **Google Sign-In not working**:
   - Verify SHA-1 fingerprints in Firebase Console
   - Check OAuth client configuration

3. **Build errors**:
   - Run `flutter clean && flutter pub get`
   - Check Flutter and Dart SDK versions

4. **Emulator issues**:
   - Ensure Firebase emulators are running
   - Check emulator configuration

### Debug Commands
```bash
# Check Flutter doctor
flutter doctor

# Analyze code
flutter analyze

# Check dependencies
flutter pub deps

# Clean build
flutter clean
flutter pub get
```

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Material Design Guidelines](https://material.io/design)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy coding! 🎉**
