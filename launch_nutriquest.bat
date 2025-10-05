@echo off
echo ========================================
echo    NutriQuest Universal Launcher
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo NutriQuest Universal Launcher
echo Choose your preferred method:
echo.
echo 1. Working Quiz (HTML) - Guaranteed to work
echo 2. Demo Flutter App - If Flutter is installed
echo 3. Simple Flutter App - No Firebase needed
echo 4. Server Demo - Python server with all files
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto :quiz
if "%choice%"=="2" goto :demo
if "%choice%"=="3" goto :simple
if "%choice%"=="4" goto :server
goto :quiz

:quiz
echo.
echo Opening Working Quiz...
start "" "nutriquest_quiz.html"
echo ✅ Working quiz opened in your browser!
goto :end

:demo
echo.
echo Starting Demo Flutter App...
flutter run lib/main_demo.dart -d chrome --web-port=3000
goto :end

:simple
echo.
echo Starting Simple Flutter App...
flutter run lib/main_simple.dart -d chrome --web-port=3000
goto :end

:server
echo.
echo Starting Python Server...
start /b python -m http.server 3000
timeout /t 3 /nobreak >nul
start http://localhost:3000/
echo ✅ Server started! Available at http://localhost:3000/
goto :end

:end
echo.
echo NutriQuest launched successfully!
echo.
pause
