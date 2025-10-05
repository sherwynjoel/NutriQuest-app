@echo off
echo ========================================
echo    NutriQuest - Starting Server
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

REM Start Python server
start /b python -m http.server 3000

REM Wait for server to start
timeout /t 3 /nobreak >nul

REM Open browser
start http://localhost:3000/

echo.
echo NutriQuest should now be running!
echo If you see the directory listing, click on 'quiz_test.html' to see the working quiz.
echo.

pause
