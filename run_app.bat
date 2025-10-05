@echo off
echo ========================================
echo    NutriQuest Flutter App Launcher
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Step 1: Cleaning previous builds...
flutter clean
if %errorlevel% neq 0 (
    echo ERROR: Flutter clean failed
    echo Please make sure Flutter is installed properly
    pause
    exit /b 1
)

echo.
echo Step 2: Getting dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo ERROR: Flutter pub get failed
    pause
    exit /b 1
)

echo.
echo Step 3: Starting Flutter web server...
echo This will open your browser automatically...
echo If it doesn't open, go to: http://localhost:8080
echo.

flutter run -d chrome --web-port=8080 --web-hostname=localhost
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Flutter run failed
    echo Trying alternative method...
    echo.
    flutter run -d edge --web-port=8080
)

echo.
echo If you see this message, Flutter has stopped
pause
