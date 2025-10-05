@echo off
title NutriQuest Launcher
echo ========================================
echo    NutriQuest - PERMANENT LAUNCHER
echo ========================================
echo.

REM Force kill ALL possible server processes
echo [1/5] Stopping all existing servers...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im php.exe >nul 2>&1
taskkill /f /im http-server.exe >nul 2>&1
timeout /t 3 /nobreak >nul

REM Force change to project directory
echo [2/5] Changing to project directory...
cd /d "%~dp0"
echo Current directory: %CD%

REM Verify we're in the right directory
echo [3/5] Verifying project files...
if not exist "nutriquest_quiz.html" (
    echo ERROR: Not in NutriQuest directory!
    echo Current path: %CD%
    echo Expected files not found.
    pause
    exit /b 1
)

if not exist "food_sort_game.html" (
    echo ERROR: Project files incomplete!
    pause
    exit /b 1
)

echo ✅ Project directory verified successfully!

REM Create a simple index redirect
echo [4/5] Setting up project structure...
echo ^<!DOCTYPE html^> > temp_index.html
echo ^<html^>^<head^>^<title^>NutriQuest^</title^>^</head^>^<body^> >> temp_index.html
echo ^<h1^>NutriQuest Educational Gaming Platform^</h1^> >> temp_index.html
echo ^<p^>Choose your game:^</p^> >> temp_index.html
echo ^<ul^> >> temp_index.html
echo ^<li^>^<a href="nutriquest_quiz.html"^>🧠 Nutrition Quiz^</a^>^</li^> >> temp_index.html
echo ^<li^>^<a href="food_sort_game.html"^>🥗 Food Sort Game^</a^>^</li^> >> temp_index.html
echo ^<li^>^<a href="meal_builder_game.html"^>🍽️ Meal Builder^</a^>^</li^> >> temp_index.html
echo ^<li^>^<a href="learning_hub.html"^>📚 Learning Hub^</a^>^</li^> >> temp_index.html
echo ^<li^>^<a href="games_hub.html"^>🎮 All Games^</a^>^</li^> >> temp_index.html
echo ^<li^>^<a href="web/index.html"^>🌐 Demo Interface^</a^>^</li^> >> temp_index.html
echo ^</ul^> >> temp_index.html
echo ^</body^>^</html^> >> temp_index.html

REM Start server with explicit directory
echo [5/5] Starting server from project directory...
echo.
echo ✅ NutriQuest server starting...
echo 📍 Server running from: %CD%
echo 🌐 Opening browser...
echo.

REM Start server in background and open browser
start /b python -m http.server 3000
timeout /t 2 /nobreak >nul
start http://localhost:3000/

echo.
echo ========================================
echo    NutriQuest is now running!
echo ========================================
echo.
echo Available at: http://localhost:3000/
echo.
echo Games available:
echo - Nutrition Quiz: http://localhost:3000/nutriquest_quiz.html
echo - Food Sort Game: http://localhost:3000/food_sort_game.html
echo - Meal Builder: http://localhost:3000/meal_builder_game.html
echo - Learning Hub: http://localhost:3000/learning_hub.html
echo - All Games: http://localhost:3000/games_hub.html
echo.
echo Press Ctrl+C to stop the server
echo.

REM Keep the window open and show server status
:server_loop
python -m http.server 3000
if %errorlevel% neq 0 (
    echo.
    echo Server stopped. Press any key to restart or close window to exit.
    pause >nul
    goto server_loop
)
