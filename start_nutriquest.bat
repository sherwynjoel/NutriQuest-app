@echo off
title NutriQuest - Educational Gaming Platform
color 0A

echo.
echo ███╗   ██╗██╗   ██╗████████╗██████╗ ██╗     ██╗   ██╗███████╗███████╗████████╗
echo ████╗  ██║██║   ██║╚══██╔══╝██╔══██╗██║     ██║   ██║██╔════╝██╔════╝╚══██╔══╝
echo ██╔██╗ ██║██║   ██║   ██║   ██████╔╝██║     ██║   ██║███████╗█████╗     ██║   
echo ██║╚██╗██║██║   ██║   ██║   ██╔══██╗██║     ██║   ██║╚════██║██╔══╝     ██║   
echo ██║ ╚████║╚██████╔╝   ██║   ██║  ██║███████╗╚██████╔╝███████║███████╗   ██║   
echo ╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝   
echo.
echo                    🎮 Educational Gaming Platform 🎮
echo.
echo ========================================
echo    Choose how to run NutriQuest:
echo ========================================
echo.
echo 1. 🌐 Web Version (Recommended)
echo    - Works on any device
echo    - No installation needed
echo    - Access from phone/tablet
echo.
echo 2. 📱 Phone Demo
echo    - Optimized for mobile
echo    - Direct phone access
echo.
echo 3. 🖥️  Computer Only
echo    - Local browser access
echo.
echo 4. 🚀 Flutter App (if installed)
echo    - Native mobile app
echo.
echo 5. ❌ Exit
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto :web
if "%choice%"=="2" goto :phone
if "%choice%"=="3" goto :computer
if "%choice%"=="4" goto :flutter
if "%choice%"=="5" goto :exit
goto :web

:web
echo.
echo 🌐 Starting Web Version...
echo.
REM Kill existing servers
taskkill /F /IM python.exe 2>nul
REM Change to project directory
cd /d "%~dp0"
REM Start server
start /b python -m http.server 3000
timeout /t 2 /nobreak >nul
start http://localhost:3000/
echo.
echo ✅ NutriQuest is running!
echo.
echo 🌐 Computer: http://localhost:3000/
echo 📱 Phone:    http://192.168.0.102:3000/
echo.
echo Press any key to stop server...
pause >nul
taskkill /F /IM python.exe 2>nul
goto :end

:phone
echo.
echo 📱 Starting Phone Demo...
echo.
REM Kill existing servers
taskkill /F /IM python.exe 2>nul
REM Change to project directory
cd /d "%~dp0"
REM Start server
start /b python -m http.server 3000
timeout /t 2 /nobreak >nul
echo.
echo ✅ NutriQuest is running!
echo.
echo 📱 On your phone, open browser and go to:
echo    http://192.168.0.102:3000/
echo.
echo 🎮 Direct game links:
echo    Quiz: http://192.168.0.102:3000/nutriquest_quiz.html
echo    Games: http://192.168.0.102:3000/games_hub.html
echo.
echo Press any key to stop server...
pause >nul
taskkill /F /IM python.exe 2>nul
goto :end

:computer
echo.
echo 🖥️ Starting Computer Version...
echo.
REM Kill existing servers
taskkill /F /IM python.exe 2>nul
REM Change to project directory
cd /d "%~dp0"
REM Start server
start /b python -m http.server 3000
timeout /t 2 /nobreak >nul
start http://localhost:3000/
echo.
echo ✅ NutriQuest is running on your computer!
echo.
echo 🌐 Access: http://localhost:3000/
echo.
echo Press any key to stop server...
pause >nul
taskkill /F /IM python.exe 2>nul
goto :end

:flutter
echo.
echo 🚀 Starting Flutter App...
echo.
echo Note: This requires Flutter to be installed and configured.
echo.
flutter run -d chrome
goto :end

:exit
echo.
echo 👋 Thanks for using NutriQuest!
echo.
goto :end

:end
echo.
echo 🎉 NutriQuest Demo Complete!
echo.
pause