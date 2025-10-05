@echo off
echo ========================================
echo    Fixing Flutter PATH Issues
echo ========================================
echo.

REM Add common Flutter installation paths to PATH
set PATH=%PATH%;C:\flutter\bin
set PATH=%PATH%;C:\src\flutter\bin
set PATH=%PATH%;%USERPROFILE%\flutter\bin
set PATH=%PATH%;%USERPROFILE%\AppData\Local\Android\Sdk\flutter\bin

echo Updated PATH with common Flutter locations
echo.

REM Check if Flutter is now accessible
flutter --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Flutter is now accessible!
    flutter --version
) else (
    echo ❌ Flutter still not found. Please install Flutter first.
    echo.
    echo Download Flutter from: https://flutter.dev/docs/get-started/install
    echo.
    echo After installation, add Flutter to your PATH:
    echo 1. Open System Properties
    echo 2. Click Environment Variables
    echo 3. Edit PATH variable
    echo 4. Add your Flutter bin directory
    echo.
)

echo.
pause
