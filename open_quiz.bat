@echo off
echo ========================================
echo    NutriQuest Quiz - Opening Now
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Starting Python server on port 3001...
echo Opening quiz in browser...
echo.

REM Start Python server in background
start /b python -m http.server 3001

REM Wait a moment for server to start
timeout /t 3 /nobreak >nul

REM Open browser to quiz
start http://localhost:3001/quiz_test.html

echo.
echo If the browser didn't open, try these URLs:
echo - http://localhost:3001/quiz_test.html
echo - http://localhost:3001/
echo.
echo Or open the file directly:
echo - file:///C:/Users/Sherwyn joel/OneDrive/Desktop/NutriQuest/quiz_test.html
echo.

pause
