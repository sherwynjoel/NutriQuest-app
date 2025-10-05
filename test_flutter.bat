@echo off
echo Testing Flutter Installation...
echo.

cd /d "C:\Users\Sherwyn joel\OneDrive\Desktop\NutriQuest"

echo Current directory: %CD%
echo.

echo Checking Flutter installation...
where flutter
if %errorlevel% neq 0 (
    echo Flutter not found in PATH
    echo Trying to find Flutter installation...
    if exist "C:\flutter\bin\flutter.bat" (
        echo Found Flutter at C:\flutter\bin\flutter.bat
        set PATH=%PATH%;C:\flutter\bin
    ) else (
        echo Flutter not found. Please install Flutter first.
        pause
        exit /b 1
    )
)

echo.
echo Running Flutter Doctor...
flutter doctor

echo.
echo Starting Flutter app...
echo This will open in your browser...
echo.

flutter run -d chrome --web-port=8080

pause
