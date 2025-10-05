@echo off
echo ========================================
echo    NutriQuest Demo Server
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

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
echo No HTTP server found. Please install one of the following:
echo - Python (https://python.org)
echo - Node.js (https://nodejs.org)
echo - PHP (https://php.net)
echo.
echo Or manually open: web/index.html in your browser
echo.

:end
pause
