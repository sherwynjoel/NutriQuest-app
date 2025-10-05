@echo off
echo ========================================
echo    NutriQuest Demo App Launcher
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Starting NutriQuest Demo App...
echo.

REM Try to run the demo Flutter app
echo Attempting to run Flutter demo app...
flutter run lib/main_demo.dart -d chrome --web-port=3000 >nul 2>&1

if %errorlevel% equ 0 (
    echo ✅ Flutter demo app started successfully!
    echo Opening browser...
    start http://localhost:3000
) else (
    echo ❌ Flutter not available. Starting alternative demo...
    echo.
    
    REM Start Python server as fallback
    echo Starting Python server...
    start /b python -m http.server 3000
    
    REM Wait for server to start
    timeout /t 3 /nobreak >nul
    
    REM Open browser
    start http://localhost:3000/nutriquest_quiz.html
    
    echo.
    echo ✅ Alternative demo started!
    echo Working quiz available at: http://localhost:3000/nutriquest_quiz.html
)

echo.
pause
