@echo off
echo ========================================
echo    NutriQuest Demo - Opening in Browser
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Opening NutriQuest demo in your browser...
echo.

REM Try different ports
echo Trying port 3000...
start http://localhost:3000
timeout /t 2 /nobreak >nul

echo Trying port 8080...
start http://localhost:8080
timeout /t 2 /nobreak >nul

echo Trying port 5000...
start http://localhost:5000
timeout /t 2 /nobreak >nul

echo.
echo If the browser didn't open automatically, try these URLs:
echo - http://localhost:3000
echo - http://localhost:8080
echo - http://localhost:5000
echo.
echo Or open the file directly:
echo - file:///C:/Users/Sherwyn joel/OneDrive/Desktop/NutriQuest/web/index.html
echo.

pause
