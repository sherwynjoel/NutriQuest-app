@echo off
echo ========================================
echo    Creating Desktop Shortcuts
echo ========================================
echo.

REM Get current directory
set "PROJECT_DIR=%~dp0"
set "DESKTOP=%USERPROFILE%\Desktop"

echo Creating desktop shortcuts for NutriQuest...
echo.

REM Create shortcut for main launcher
echo [1/4] Creating main launcher shortcut...
powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%DESKTOP%\NutriQuest Launcher.lnk'); $Shortcut.TargetPath = '%PROJECT_DIR%nutriquest_launcher.bat'; $Shortcut.WorkingDirectory = '%PROJECT_DIR%'; $Shortcut.Description = 'Launch NutriQuest Educational Gaming Platform'; $Shortcut.Save()}"

REM Create shortcut for direct access
echo [2/4] Creating direct access shortcut...
powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%DESKTOP%\NutriQuest Games (No Server).lnk'); $Shortcut.TargetPath = '%PROJECT_DIR%open_games_direct.bat'; $Shortcut.WorkingDirectory = '%PROJECT_DIR%'; $Shortcut.Description = 'Open NutriQuest games directly (no server needed)'; $Shortcut.Save()}"

REM Create shortcut for quiz
echo [3/4] Creating quiz shortcut...
powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%DESKTOP%\NutriQuest Quiz.lnk'); $Shortcut.TargetPath = '%PROJECT_DIR%nutriquest_quiz.html'; $Shortcut.WorkingDirectory = '%PROJECT_DIR%'; $Shortcut.Description = 'Open NutriQuest Quiz directly'; $Shortcut.Save()}"

REM Create shortcut for games hub
echo [4/4] Creating games hub shortcut...
powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%DESKTOP%\NutriQuest Games Hub.lnk'); $Shortcut.TargetPath = '%PROJECT_DIR%games_hub.html'; $Shortcut.WorkingDirectory = '%PROJECT_DIR%'; $Shortcut.Description = 'Open NutriQuest Games Hub'; $Shortcut.Save()}"

echo.
echo ✅ Desktop shortcuts created successfully!
echo.
echo Shortcuts created on your desktop:
echo - NutriQuest Launcher (with server)
echo - NutriQuest Games (No Server)
echo - NutriQuest Quiz (direct)
echo - NutriQuest Games Hub (direct)
echo.
echo You can now double-click any shortcut to open NutriQuest!
echo.
pause
