@echo off
echo Starting NutriQuest App (Simple Version)...
echo.

REM Navigate to project directory
cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

REM Clean previous builds
echo Cleaning previous builds...
flutter clean

REM Get dependencies
echo Getting dependencies...
flutter pub get

REM Run the simple version
echo Starting app...
flutter run -d chrome lib/main_simple.dart

pause
