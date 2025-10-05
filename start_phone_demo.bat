@echo off
echo ========================================
echo    NutriQuest Phone Demo Server
echo ========================================
echo.

REM Kill any existing Python servers
echo Killing existing Python servers...
taskkill /F /IM python.exe 2>nul

REM Change to the correct directory
echo Changing to NutriQuest directory...
cd /d "%~dp0"

REM Verify we're in the right directory
echo Current directory: %CD%
echo.

REM Check if key files exist
if not exist "index.html" (
    echo ERROR: index.html not found!
    echo Please make sure you're running this from the NutriQuest directory.
    pause
    exit /b 1
)

echo ✅ All files found! Starting server...
echo.

REM Start the Python server
echo Starting Python server on port 3000...
start /b python -m http.server 3000

REM Wait a moment for server to start
timeout /t 3 /nobreak >nul

echo.
echo ✅ NutriQuest is now running!
echo.
echo 📱 PHONE ACCESS:
echo    Open your phone's browser and go to:
echo    http://192.168.0.102:3000/
echo.
echo 🎮 Direct Game Links for Phone:
echo    Quiz Game: http://192.168.0.102:3000/nutriquest_quiz.html
echo    Games Hub: http://192.168.0.102:3000/games_hub.html
echo    Food Sort: http://192.168.0.102:3000/food_sort_game.html
echo    Meal Builder: http://192.168.0.102:3000/meal_builder_game.html
echo    Learning Hub: http://192.168.0.102:3000/learning_hub.html
echo.
echo 💻 Computer Access:
echo    http://localhost:3000/
echo.
echo Press any key to stop the server...
pause >nul

REM Stop the server
echo Stopping server...
taskkill /F /IM python.exe 2>nul
echo Server stopped.
