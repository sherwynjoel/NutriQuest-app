@echo off
echo ========================================
echo    NutriQuest - Open All Games
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Opening all NutriQuest games directly...
echo.

REM Open all games directly in browser (no server needed)
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
echo No server needed - files opened directly.
echo.

pause
