# Platform-Specific Setup Guide for NutriQuest

## 🤖 Android Setup

### 1. Google Services Configuration
- **File**: `android/app/google-services.json`
- **Purpose**: Firebase configuration for Android
- **Setup**: Download from Firebase Console → Project Settings → Your apps → Android

### 2. Build Configuration
- **File**: `android/app/build.gradle`
- **Features**:
  - Firebase BOM integration
  - Google Services plugin
  - MultiDex support
  - Minimum SDK 21 (Android 5.0)
  - Target SDK 33 (Android 13)

### 3. Project Configuration
- **File**: `android/build.gradle`
- **Features**:
  - Kotlin support
  - Google Services plugin
  - Gradle 7.3.0

### 4. Required Permissions
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

## 🍎 iOS Setup

### 1. Google Services Configuration
- **File**: `ios/Runner/GoogleService-Info.plist`
- **Purpose**: Firebase configuration for iOS
- **Setup**: Download from Firebase Console → Project Settings → Your apps → iOS

### 2. Info.plist Configuration
- **File**: `ios/Runner/Info.plist`
- **Features**:
  - Camera and Photo Library permissions
  - URL schemes for authentication
  - Display name: "NutriQuest"
  - Bundle identifier: com.nutriquest.app

### 3. Required Permissions
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs access to camera to take profile photos.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to select profile photos.</string>
```

## 🔧 Setup Instructions

### Android Setup
1. **Download google-services.json**:
   - Go to Firebase Console
   - Select your project
   - Go to Project Settings
   - Add Android app
   - Download google-services.json
   - Place in `android/app/` directory

2. **Update build.gradle**:
   - The files are already configured
   - Ensure Google Services plugin is applied
   - Verify Firebase dependencies

3. **Test the setup**:
   ```bash
   flutter run
   ```

### iOS Setup
1. **Download GoogleService-Info.plist**:
   - Go to Firebase Console
   - Select your project
   - Go to Project Settings
   - Add iOS app
   - Download GoogleService-Info.plist
   - Place in `ios/Runner/` directory

2. **Update Info.plist**:
   - The file is already configured
   - Verify permissions are set
   - Check URL schemes

3. **Test the setup**:
   ```bash
   flutter run -d ios
   ```

## 🚨 Troubleshooting

### Android Issues
- **Build errors**: Check google-services.json is in correct location
- **Firebase not working**: Verify Google Services plugin is applied
- **Permission denied**: Check AndroidManifest.xml permissions

### iOS Issues
- **Build errors**: Check GoogleService-Info.plist is in correct location
- **Firebase not working**: Verify plist file is added to Xcode project
- **Permission denied**: Check Info.plist permissions

### Common Solutions
1. **Clean and rebuild**:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Check Firebase project**:
   - Ensure project is created
   - Verify services are enabled
   - Check configuration files

3. **Verify dependencies**:
   - Check pubspec.yaml
   - Ensure Firebase packages are added
   - Verify platform-specific files

## 📱 Platform-Specific Features

### Android Features
- **MultiDex**: Support for large apps
- **Camera integration**: Profile photo capture
- **File storage**: Local data persistence
- **Background processing**: Game progress sync

### iOS Features
- **Photo library access**: Profile photo selection
- **Camera integration**: Profile photo capture
- **Background app refresh**: Game progress sync
- **Push notifications**: Achievement alerts

## 🔐 Security Considerations

### Android Security
- **ProGuard**: Code obfuscation for release builds
- **Network security**: HTTPS enforcement
- **File permissions**: Secure local storage

### iOS Security
- **App Transport Security**: HTTPS enforcement
- **Keychain**: Secure credential storage
- **File permissions**: Secure local storage

---
**Your NutriQuest app is now configured for both Android and iOS! 🎉**
