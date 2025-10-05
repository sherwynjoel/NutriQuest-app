@echo off
echo ========================================
echo    NutriQuest - Final Launcher
echo ========================================
echo.

REM Kill any existing Python servers
echo Stopping any existing servers...
taskkill /f /im python.exe >nul 2>&1

REM Change to the correct directory
cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Current directory: %CD%
echo.

REM Verify we're in the right directory
if not exist "nutriquest_quiz.html" (
    echo ERROR: Not in NutriQuest directory!
    echo Please run this from the NutriQuest project folder.
    pause
    exit /b 1
)

echo ✅ Confirmed: In NutriQuest project directory
echo.

echo Starting Python server on port 3000...
echo Opening NutriQuest in browser...
echo.

REM Start Python server in background
start /b python -m http.server 3000

REM Wait for server to start
timeout /t 3 /nobreak >nul

REM Open browser to the project
start http://localhost:3000/

echo.
echo ✅ NutriQuest server is now running correctly!
echo.
echo Available URLs:
echo - http://localhost:3000/ (Main page)
echo - http://localhost:3000/nutriquest_quiz.html (Working Quiz)
echo - http://localhost:3000/food_sort_game.html (Food Sort Game)
echo - http://localhost:3000/meal_builder_game.html (Meal Builder)
echo - http://localhost:3000/learning_hub.html (Learning Hub)
echo - http://localhost:3000/games_hub.html (All Games)
echo - http://localhost:3000/web/index.html (Demo Interface)
echo.

echo Press any key to stop the server...
pause >nul

echo.
echo Stopping server...
taskkill /f /im python.exe >nul 2>&1
echo Server stopped.
