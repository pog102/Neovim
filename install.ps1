# Windows-specific installation script for Neovim configuration

# This script installs Neovim and the configuration files to the correct location on Windows.

# Source directory (where this script is located)
$sourceDir = $PSScriptRoot

# Destination directory for Neovim configuration on Windows
$destinationDir = "$env:LOCALAPPDATA\nvim"

# Files and directories to exclude from copying
$exclude = @(
    ".git",
    "install.ps1"
)

# --- Script Execution ---

# 1. Check if running on Windows
if ($IsWindows -ne $true) {
    Write-Error "This script is intended to be run on Windows."
    exit 1
}

# 2. Check if Neovim is installed, and install it if not
if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "Neovim not found. Attempting to install with winget..."
    try {
        winget install Neovim.Neovim --source winget --accept-source-agreements --accept-package-agreements
    } catch {
        Write-Error "Failed to install Neovim with winget. Please install it manually."
        exit 1
    }
} else {
    Write-Host "Neovim is already installed."
}

# 3. Create destination directory if it doesn't exist
if (-not (Test-Path -Path $destinationDir)) {
    Write-Host "Creating destination directory: $destinationDir"
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}

# 4. Copy files and directories
Write-Host "Copying configuration files from $sourceDir to $destinationDir"
Get-ChildItem -Path $sourceDir -Exclude $exclude -Recurse | ForEach-Object {
    $sourcePath = $_.FullName
    $destinationPath = $sourcePath.Replace($sourceDir, $destinationDir)
    
    if ($_.PSIsContainer) {
        # Create directory if it doesn't exist
        if (-not (Test-Path -Path $destinationPath)) {
            New-Item -ItemType Directory -Path $destinationPath | Out-Null
        }
    } else {
        # Copy file
        Copy-Item -Path $sourcePath -Destination $destinationPath -Force
    }
}

Write-Host "Installation complete."

