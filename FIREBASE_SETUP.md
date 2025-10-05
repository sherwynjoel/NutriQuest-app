# Firebase Setup Guide for NutriQuest

## 🚀 Quick Firebase Setup

### Step 1: Create Firebase Project

1. **Go to [Firebase Console](https://console.firebase.google.com/)**
2. **Click "Create a project"**
3. **Project name**: `nutriquest-app`
4. **Enable Google Analytics** (optional)
5. **Create project**

### Step 2: Enable Authentication

1. **Go to Authentication → Sign-in method**
2. **Enable "Google" provider**
3. **Add your domain** (for web deployment)
4. **Save changes**

### Step 3: Enable Firestore Database

1. **Go to Firestore Database**
2. **Click "Create database"**
3. **Start in test mode** (for development)
4. **Choose location** (closest to your users)

### Step 4: Enable Cloud Storage

1. **Go to Storage**
2. **Click "Get started"**
3. **Start in test mode** (for development)
4. **Choose location**

### Step 5: Get Configuration

1. **Go to Project Settings** (gear icon)
2. **Scroll down to "Your apps"**
3. **Click "Add app" → Web**
4. **App nickname**: `nutriquest-web`
5. **Copy the configuration**

### Step 6: Update firebase_options.dart

Replace the placeholder values in `lib/firebase_options.dart`:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_ACTUAL_API_KEY',
  appId: 'YOUR_ACTUAL_APP_ID',
  messagingSenderId: 'YOUR_ACTUAL_SENDER_ID',
  projectId: 'YOUR_ACTUAL_PROJECT_ID',
  authDomain: 'YOUR_ACTUAL_AUTH_DOMAIN',
  storageBucket: 'YOUR_ACTUAL_STORAGE_BUCKET',
);
```

### Step 7: Security Rules (Optional)

#### Firestore Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /leaderboard/{userId} {
      allow read: if request.auth != null;
    }
  }
}
```

#### Storage Rules
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

## 🎯 Testing Your Setup

1. **Run the app**: `flutter run -d chrome`
2. **Try Google Sign-In**: Should work if Firebase is configured
3. **Check Firestore**: Data should appear in Firebase Console
4. **Test Storage**: Upload images should work

## 🚨 Troubleshooting

### Common Issues:

1. **"Firebase not initialized"**
   - Check `firebase_options.dart` has correct values
   - Ensure Firebase project is created

2. **"Google Sign-In not working"**
   - Verify Google provider is enabled
   - Check OAuth client configuration

3. **"Permission denied"**
   - Update Firestore security rules
   - Check authentication status

4. **"Network error"**
   - Check internet connection
   - Verify Firebase project is active

## 📱 Platform-Specific Setup

### Android
- Download `google-services.json`
- Place in `android/app/` directory

### iOS
- Download `GoogleService-Info.plist`
- Place in `ios/Runner/` directory

### Web
- Update `firebase_options.dart` with web configuration

## 🔧 Development vs Production

### Development
- Use test mode for Firestore and Storage
- Relaxed security rules
- Local development domains

### Production
- Enable production security rules
- Set up proper authentication
- Configure custom domains
- Enable monitoring and analytics

---

**Your NutriQuest app is now ready with Firebase! 🎉**
