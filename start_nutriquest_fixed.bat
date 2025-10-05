@echo off
echo ========================================
echo    NutriQuest - Fixed Server Startup
echo ========================================
echo.

REM Change to the correct directory
cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Current directory: %CD%
echo.

REM Kill any existing Python servers
taskkill /f /im python.exe >nul 2>&1

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
echo NutriQuest server is now running!
echo.
echo Available URLs:
echo - http://localhost:3000/ (Project directory)
echo - http://localhost:3000/nutriquest_quiz.html (Working Quiz)
echo - http://localhost:3000/web/index.html (Demo Interface)
echo.

pause
