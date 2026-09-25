<#
.SYNOPSIS
    Agrovia Organic Farms - Git Auto-Setup & GitHub Push Script
    Target Repository: https://github.com/BongominRonald/Agrovia
#>

Set-Location -Path $PSScriptRoot

Write-Host "===============================================================================" -ForegroundColor Green
Write-Host "       Agrovia Organic Farms - Git Initialization and GitHub Auto-Push" -ForegroundColor Cyan
Write-Host "                Target Account: github.com/BongominRonald" -ForegroundColor Yellow
Write-Host "                Target Repo:    github.com/BongominRonald/Agrovia" -ForegroundColor Yellow
Write-Host "===============================================================================" -ForegroundColor Green
Write-Host ""

# Check for Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Git is not installed or not in your system PATH." -ForegroundColor Red
    Write-Host "Please install Git from https://git-scm.com/ and re-run this script." -ForegroundColor Yellow
    Pause
    exit 1
}

# Initialize or inspect Git repo
if (-not (Test-Path ".git")) {
    Write-Host "[*] Initializing new Git repository with main branch..." -ForegroundColor Cyan
    git init -b main
    if ($LASTEXITCODE -ne 0) {
        git init
        git branch -M main
    }
} else {
    Write-Host "[*] Existing Git repository detected. Ensuring branch is 'main'..." -ForegroundColor Cyan
    git branch -M main
}

# Configure Remote Origin
$remoteCheck = git remote get-url origin 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[*] Adding remote origin (https://github.com/BongominRonald/Agrovia.git)..." -ForegroundColor Cyan
    git remote add origin https://github.com/BongominRonald/Agrovia.git
} else {
    Write-Host "[*] Setting remote origin URL to https://github.com/BongominRonald/Agrovia.git..." -ForegroundColor Cyan
    git remote set-url origin https://github.com/BongominRonald/Agrovia.git
}

# Stage files
Write-Host "[*] Staging all files..." -ForegroundColor Cyan
git add .

# Commit files
Write-Host "[*] Committing all files..." -ForegroundColor Cyan
git commit -m "feat: complete enterprise Agrovia organic agriculture platform with all premium features, interactive components, and AJAX handlers"

# Push to GitHub
Write-Host ""
Write-Host "[*] Pushing to GitHub (https://github.com/BongominRonald/Agrovia.git)..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "===============================================================================" -ForegroundColor Green
    Write-Host "[SUCCESS] Agrovia platform successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "Repository URL: https://github.com/BongominRonald/Agrovia" -ForegroundColor Cyan
    Write-Host "===============================================================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[!] HTTPS push encountered an error. Attempting SSH fallback..." -ForegroundColor Yellow
    git remote set-url origin git@github.com:BongominRonald/Agrovia.git
    git push -u origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "===============================================================================" -ForegroundColor Green
        Write-Host "[SUCCESS] Agrovia platform successfully pushed via SSH!" -ForegroundColor Green
        Write-Host "Repository URL: https://github.com/BongominRonald/Agrovia" -ForegroundColor Cyan
        Write-Host "===============================================================================" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "[!] Push failed. Please check:" -ForegroundColor Red
        Write-Host "  1. The repo 'Agrovia' is created on https://github.com/BongominRonald/Agrovia" -ForegroundColor Yellow
        Write-Host "  2. You have permission to push to BongominRonald/Agrovia" -ForegroundColor Yellow
        Write-Host "  3. Your GitHub credentials / Personal Access Token or SSH keys are valid." -ForegroundColor Yellow
    }
}

Write-Host ""
Pause
