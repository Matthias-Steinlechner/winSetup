@echo off

:: Initialize variables for team selections
set /p "isOps=Are you in the Ops Team? (y/n): "
set /p "isDev=Are you in the Dev Team? (y/n): "
set /p "isManagement=Are you in the Management Team? (y/n): "

:: Install Standard Software
winget install -e --id Mozilla.Firefox
winget install -e --id Google.Chrome
winget install -e --id Notion.Notion
winget install -e --id Microsoft.Teams
winget install -e --id Microsoft.Office
winget install -e --id TheDocumentFoundation.LibreOffice
winget install -e --id KeePassXCTeam.KeePassXC
winget install -e --id IrfanSkiljan.IrfanView
winget install -e --id GIMP.GIMP

:: Install Software Based on Team Selections
if /i "%isOps%"=="y" (
    :: Ops Team: Manual installation of JasperStudio
    echo You are in the Ops Team. Please install JasperStudio manually.
)

if /i "%isDev%"=="y" (
    :: Dev Team: Install development-related software
    winget install -e --id Git.Git
    winget install -e --id OpenJS.NodeJS
    winget install -e --id Docker.DockerDesktop
    winget install -e --id JetBrains.PHPStorm
)

if /i "%isManagement%"=="y" (
    :: Management Team: Install management-related software
    winget install -e --id AgileBits.1Password
)

:: Pause to keep the command window open
pause
