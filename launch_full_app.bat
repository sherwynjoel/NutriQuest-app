@echo off
echo ========================================
echo    NutriQuest - Full Flutter App
echo ========================================
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Starting the full NutriQuest Flutter app...
echo This will open the interactive version with working games.
echo.

REM Try to find Flutter in common locations
set FLUTTER_PATH=""

if exist "C:\flutter\bin\flutter.bat" set FLUTTER_PATH="C:\flutter\bin\flutter.bat"
if exist "C:\src\flutter\bin\flutter.bat" set FLUTTER_PATH="C:\src\flutter\bin\flutter.bat"
if exist "%USERPROFILE%\flutter\bin\flutter.bat" set FLUTTER_PATH="%USERPROFILE%\flutter\bin\flutter.bat"

if %FLUTTER_PATH%=="" (
    echo Flutter not found in common locations.
    echo Please use VS Code or Android Studio to run the app.
    echo.
    echo Opening VS Code...
    code .
    pause
    goto :end
)

echo Found Flutter at: %FLUTTER_PATH%
echo Starting Flutter app...
echo.

%FLUTTER_PATH% run -d chrome --web-port=3000

:end
pause
