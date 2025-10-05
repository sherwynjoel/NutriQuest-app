@echo off
title NutriQuest Demo - Permanent Fix
echo ========================================
echo    NutriQuest Demo - PERMANENT FIX
echo ========================================
echo.

REM Kill ALL server processes first
echo [STEP 1] Stopping all existing servers...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im php.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Force change to the script's directory (project directory)
echo [STEP 2] Changing to project directory...
cd /d "%~dp0"
echo Current directory: %CD%

REM Verify project files exist
echo [STEP 3] Verifying project files...
if not exist "nutriquest_quiz.html" (
    echo ❌ ERROR: Not in NutriQuest project directory!
    echo Current path: %CD%
    echo Expected file 'nutriquest_quiz.html' not found.
    echo.
    echo Please ensure this batch file is in the NutriQuest project folder.
    pause
    exit /b 1
)

echo ✅ Project directory verified!

REM Start server from project directory
echo [STEP 4] Starting server from project directory...
echo.
echo 🌐 Opening NutriQuest in browser...
echo 📍 Server running from: %CD%
echo.

REM Start server and open browser
start /b python -m http.server 3000
timeout /t 3 /nobreak >nul
start http://localhost:3000/

echo.
echo ========================================
echo    NutriQuest Demo is now running!
echo ========================================
echo.
echo ✅ Server started successfully from project directory
echo 🌐 Browser opened to: http://localhost:3000/
echo.
echo Available games:
echo - Quiz: http://localhost:3000/nutriquest_quiz.html
echo - Food Sort: http://localhost:3000/food_sort_game.html
echo - Meal Builder: http://localhost:3000/meal_builder_game.html
echo - Learning Hub: http://localhost:3000/learning_hub.html
echo - All Games: http://localhost:3000/games_hub.html
echo.
echo Press any key to stop the server and exit...
pause >nul

echo.
echo Stopping server...
taskkill /f /im python.exe >nul 2>&1
echo Server stopped.
