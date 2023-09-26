@echo off

:: Initialize variables for team selections and installation status
set /p "isOps=Are you in the Ops Team? (y/n): "
set /p "isDev=Are you in the Dev Team? (y/n): "
set /p "isManagement=Are you in the Management Team? (y/n): "
set "successfulInstalls="
set "failedInstalls="

:: Function to install software and track installation status
:installSoftware
set "app=%1"
shift
winget install -e --id %app%
if %errorlevel% equ 0 (
    set "successfulInstalls=%successfulInstalls% %app%"
) else (
    set "failedInstalls=%failedInstalls% %app% (Error: %errorlevel%)"
)
goto :eof

:: Install Standard Software
call :installSoftware Mozilla.Firefox
call :installSoftware Google.Chrome
call :installSoftware Notion.Notion
call :installSoftware Microsoft.Teams
call :installSoftware Microsoft.Office
call :installSoftware TheDocumentFoundation.LibreOffice
call :installSoftware KeePassXCTeam.KeePassXC
call :installSoftware IrfanSkiljan.IrfanView
call :installSoftware GIMP.GIMP

:: Install Software Based on Team Selections
if /i "%isOps%"=="y" (
    :: Ops Team: Manual installation of JasperStudio
    echo You are in the Ops Team. Please install JasperStudio manually.
)

if /i "%isDev%"=="y" (
    :: Dev Team: Install development-related software
    call :installSoftware Git.Git
    call :installSoftware OpenJS.NodeJS
    call :installSoftware Docker.DockerDesktop
    call :installSoftware JetBrains.PHPStorm
)

if /i "%isManagement%"=="y" (
    :: Management Team: Install management-related software
    call :installSoftware AgileBits.1Password
)

:: Display installation results
echo Successful installations:%successfulInstalls%
echo Failed installations:%failedInstalls%

:: Pause to keep the command window open
pause
