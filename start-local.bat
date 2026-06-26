@echo off
setlocal
cd /d "%~dp0"

where node >nul 2>&1
if errorlevel 1 (
    echo Node.js was not found on PATH.
    echo Install Node.js from https://nodejs.org/ and run this file again.
    pause
    exit /b 1
)

powershell -NoProfile -Command "if (Get-NetTCPConnection -State Listen -LocalPort 8787 -ErrorAction SilentlyContinue) { exit 0 }; exit 1"
if not errorlevel 1 (
    start "" "http://localhost:8787"
    exit /b 0
)

start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; Start-Process 'http://localhost:8787'"
node serve-local.mjs
