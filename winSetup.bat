@echo off

:: Initialize variables for team selections and installation status
set /p "isOps=Are you in the Ops Team? (y/n): "
set /p "isDev=Are you in the Dev Team? (y/n): "
set /p "isManagement=Are you in the Management Team? (y/n): "
set "successfulInstalls="
set "failedInstalls="

:: Define a list of software IDs to install
set "softwareList=Mozilla.Firefox Google.Chrome Notion.Notion Microsoft.Teams Microsoft.Office TheDocumentFoundation.LibreOffice KeePassXCTeam.KeePassXC IrfanSkiljan.IrfanView GIMP.GIMP"

:: Function to install software and track installation status
:installSoftware
set "app=%1"
shift
set "retryCount=0"
:retry
winget install --id %app%
if %errorlevel% equ 0 (
    set "successfulInstalls=%successfulInstalls% %app%"
) else (
    set /a "retryCount+=1"
    if %retryCount% lss 3 (
        echo Failed to install %app%. Retrying (%retryCount%)...
        timeout /t 5 /nobreak >nul
        goto retry
    ) else (
        set "failedInstalls=%failedInstalls% %app% (Error: %errorlevel%)"
    )
)
goto :eof

:: Install Standard Software
for %%s in (%softwareList%) do (
    call :installSoftware "%%s"
)

:: Install Software Based on Team Selections
if /i "%isOps%"=="y" (
    :: Ops Team: Manual installation of JasperStudio
    echo You are in the Ops Team. Please install JasperStudio manually.
)

if /i "%isDev%"=="y" (
    :: Dev Team: Install development-related software
    call :installSoftware "Git.Git"
    call :installSoftware "OpenJS.NodeJS"
    call :installSoftware "Docker.DockerDesktop"
    call :installSoftware "JetBrains.PHPStorm"
)

if /i "%isManagement%"=="y" (
    :: Management Team: Install management-related software
    call :installSoftware "AgileBits.1Password"
)

:: Display installation results
echo Successful installations:%successfulInstalls%
echo Failed installations:%failedInstalls%

:: Pause to keep the command window open
pause
