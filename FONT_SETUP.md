# Font Setup Guide for NutriQuest

## 🎨 Nunito Font Installation

### Step 1: Download Nunito Font
1. **Go to [Google Fonts - Nunito](https://fonts.google.com/specimen/Nunito)**
2. **Click "Download family"**
3. **Extract the zip file**

### Step 2: Install Font Files
1. **Copy `Nunito-Regular.ttf`** to `assets/fonts/Nunito-Regular.ttf`
2. **Copy `Nunito-Bold.ttf`** to `assets/fonts/Nunito-Bold.ttf`

### Step 3: Update pubspec.yaml
The `pubspec.yaml` is already configured with:
```yaml
fonts:
  - family: Nunito
    fonts:
      - asset: assets/fonts/Nunito-Regular.ttf
      - asset: assets/fonts/Nunito-Bold.ttf
        weight: 700
```

### Step 4: Apply Font in Theme
The font is already applied in `lib/core/theme/app_theme.dart`:
```dart
textTheme: GoogleFonts.nunitoTextTheme(),
```

## ✅ Verification
After installing the fonts:
1. **Run the app**: `flutter run`
2. **Check text**: All text should display in Nunito font
3. **Verify bold text**: Bold text should use Nunito-Bold

## 🚨 Troubleshooting
- **Font not loading**: Ensure files are in correct location
- **Build errors**: Run `flutter clean && flutter pub get`
- **Missing fonts**: Download from Google Fonts link above

---
**Your NutriQuest app will now use the beautiful Nunito font! 🎉**
