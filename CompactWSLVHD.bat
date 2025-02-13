@echo off
setlocal enabledelayedexpansion

REM ================================================
REM Please specify the path to the WSL VHD(X) file.
REM Example: set "VHD_FILE=%LOCALAPPDATA%\Packages\...\LocalState\ext4.vhdx"
REM ================================================
set "VHD_FILE=C:\wsl\ubuntu24.04lts\ext4.vhdx"

REM Check if the VHD file exists
if not exist "%VHD_FILE%" (
    echo ERROR: The specified VHD file was not found: "%VHD_FILE%"
    pause
    exit /b 1
)

REM Set the path for the temporary diskpart script file
set "DP_SCRIPT=%TEMP%\dp_script.txt"

REM Create the diskpart script
(
    echo select vdisk file="%VHD_FILE%"
    echo attach vdisk readonly
    echo compact vdisk
    echo detach vdisk
) > "%DP_SCRIPT%"

if errorlevel 1 (
    echo ERROR: Failed to create the temporary script file.
    pause
    exit /b 1
)

REM Execute diskpart
echo -------------------------------
echo Executing diskpart...
diskpart /s "%DP_SCRIPT%"
if errorlevel 1 (
    echo ERROR: An issue occurred while running diskpart.
    del "%DP_SCRIPT%" >nul 2>&1
    pause
    exit /b 1
)

REM Delete the temporary script file
del "%DP_SCRIPT%" >nul 2>&1
if exist "%DP_SCRIPT%" (
    echo WARNING: Failed to delete the temporary script file: "%DP_SCRIPT%"
) else (
    echo The temporary script file was deleted.
)

echo -------------------------------
echo Operation completed successfully. Well done!
pause
endlocal