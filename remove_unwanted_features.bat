@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrative privileges.
) else (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Set execution policy to RemoteSigned for the current user
::powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
::echo Execution policy set to RemoteSigned.

:: Disable Bing search in the Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f
echo Registry keys added successfully, Bing search results will no longer appear in the start menu.

:: Enable full right-click context menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
echo Full right-click context menu enabled.

:: Configure Start Menu to show all apps by default and hide pinned/recommended apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_ShowAllApps /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f
echo Start Menu configured to show all apps by default and hide pinned/recommended apps.

pause