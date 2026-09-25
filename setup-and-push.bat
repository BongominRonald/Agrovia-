@echo off
setlocal enabledelayedexpansion

:: Navigate to current directory
cd /d "%~dp0"

echo ===============================================================================
echo        Agrovia Organic Farms - Git Initialization and GitHub Auto-Push
echo                 Target Account: github.com/BongominRonald
echo                 Target Repo:    github.com/BongominRonald/Agrovia
echo ===============================================================================
echo.

:: Check git availability
where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git is not installed or not in your system PATH.
    echo Please install Git from https://git-scm.com/ and try again.
    pause
    exit /b 1
)

:: Initialize repository if not yet initialized
if not exist ".git" (
    echo [*] Initializing new Git repository...
    git init -b main
    if %ERRORLEVEL% NEQ 0 (
        git init
        git branch -M main
    )
) else (
    echo [*] Existing Git repository detected. Ensuring branch is 'main'...
    git branch -M main
)

:: Set remote origin to HTTPS
git remote get-url origin >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [*] Setting remote origin to https://github.com/BongominRonald/Agrovia.git...
    git remote add origin https://github.com/BongominRonald/Agrovia.git
) else (
    echo [*] Updating remote origin URL to https://github.com/BongominRonald/Agrovia.git...
    git remote set-url origin https://github.com/BongominRonald/Agrovia.git
)

:: Stage all files
echo [*] Staging all files...
git add .

:: Commit changes
echo [*] Committing files...
git commit -m "feat: complete enterprise Agrovia organic agriculture platform with all premium features, interactive components, and AJAX handlers"

:: Attempt Push via HTTPS
echo.
echo [*] Pushing to GitHub (HTTPS: https://github.com/BongominRonald/Agrovia.git)...
git push -u origin main
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===============================================================================
    echo [SUCCESS] Successfully pushed Agrovia to https://github.com/BongominRonald/Agrovia
    echo ===============================================================================
    goto :DONE
)

:: Fallback to SSH if HTTPS encounters issues
echo.
echo [!] HTTPS push encountered an issue. Trying SSH fallback (git@github.com:BongominRonald/Agrovia.git)...
git remote set-url origin git@github.com:BongominRonald/Agrovia.git
git push -u origin main
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===============================================================================
    echo [SUCCESS] Successfully pushed Agrovia to https://github.com/BongominRonald/Agrovia
    echo ===============================================================================
    goto :DONE
)

echo.
echo [!] Push encountered an authentication or remote challenge.
echo Tips:
echo   1. Ensure the repository 'Agrovia' exists at https://github.com/BongominRonald/Agrovia
echo   2. If prompted for GitHub login, authenticate with your browser or GitHub Personal Access Token.
echo   3. If using SSH, ensure your public key is added to https://github.com/settings/keys

:DONE
echo.
pause
