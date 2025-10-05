@echo off
echo ========================================
echo    NutriQuest Demo - FIXED VERSION
echo ========================================
echo.

REM Kill ALL Python processes first
echo Stopping any existing servers...
taskkill /f /im python.exe >nul 2>&1
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im php.exe >nul 2>&1

REM Wait a moment for processes to stop
timeout /t 2 /nobreak >nul

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

echo Starting NutriQuest Demo...
echo.

REM Try to use Python if available
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Using Python HTTP server...
    echo Opening browser...
    start http://localhost:3000
    python -m http.server 3000
    goto :end
)

REM Try to use Node.js if available
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Using Node.js HTTP server...
    echo Opening browser...
    start http://localhost:3000
    npx http-server -p 3000
    goto :end
)

REM Try to use PHP if available
php --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Using PHP HTTP server...
    echo Opening browser...
    start http://localhost:3000
    php -S localhost:3000
    goto :end
)

echo.
echo No HTTP server found. Opening files directly...
echo.

REM Open files directly if no server available
start "" "nutriquest_quiz.html"
start "" "games_hub.html"
start "" "web/index.html"

echo.
echo Files opened directly in browser (no server needed)
echo.

:end
pause
