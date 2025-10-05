@echo off
title NutriQuest - Direct Access (No Server)
echo ========================================
echo    NutriQuest - Direct Game Access
echo ========================================
echo.

REM Change to project directory
cd /d "%~dp0"
echo Current directory: %CD%

REM Verify project files
if not exist "nutriquest_quiz.html" (
    echo ❌ ERROR: Not in NutriQuest project directory!
    pause
    exit /b 1
)

echo ✅ Project directory verified!
echo.
echo 🎮 Opening all NutriQuest games directly...
echo (No server needed - files open directly in browser)
echo.

REM Open all games directly
start "" "nutriquest_quiz.html"
timeout /t 1 /nobreak >nul

start "" "food_sort_game.html"
timeout /t 1 /nobreak >nul

start "" "meal_builder_game.html"
timeout /t 1 /nobreak >nul

start "" "learning_hub.html"
timeout /t 1 /nobreak >nul

start "" "games_hub.html"
timeout /t 1 /nobreak >nul

start "" "web/index.html"

echo.
echo ✅ All NutriQuest games opened in your browser!
echo.
echo 🎯 Games opened:
echo - Nutrition Quiz
echo - Food Sort Game  
echo - Meal Builder
echo - Learning Hub
echo - Games Hub
echo - Demo Interface
echo.
echo No server needed - all games work directly!
echo.
pause
