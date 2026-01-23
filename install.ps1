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
# if ($IsWindows -ne $true) {
#     Write-Error "This script is intended to be run on Windows."
#     exit 1
# }

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

if (-not (Test-Path -Path $destinationDir)) {
    Write-Host "Creating destination directory: $destinationDir"
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}

# 4. Install Hack Nerd Font
Write-Host "Installing Hack Nerd Font..."
$fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
$tempDir = "$env:TEMP\HackNerdFont"
$fontZipPath = "$tempDir\Hack.zip"

# Create a temporary directory for the font download
if (-not (Test-Path -Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir | Out-Null
}

# Download the font zip file
try {
    Invoke-WebRequest -Uri $fontZipUrl -OutFile $fontZipPath
    Write-Host "Downloaded Hack Nerd Font."
} catch {
    Write-Error "Failed to download Hack Nerd Font. Please install it manually from $fontZipUrl"
    # Continue with the rest of the script
}

# Extract the font files
try {
    Expand-Archive -Path $fontZipPath -DestinationPath $tempDir -Force
    Write-Host "Extracted font files."
} catch {
    Write-Error "Failed to extract font files. Make sure you have a tool that can handle .zip files."
    # Continue with the rest of the script
}

# Install the fonts
$fontDestination = (New-Object -ComObject Shell.Application).Namespace(0x14)
$fontFiles = Get-ChildItem -Path $tempDir -Recurse -Include '*.ttf', '*.otf'
foreach ($fontFile in $fontFiles) {
    if (Test-Path -Path "$($env:windir)\Fonts\$($fontFile.Name)") {
        Write-Host "Font '$($fontFile.Name)' is already installed."
    } else {
        $fontDestination.CopyHere($fontFile.FullName)
        Write-Host "Font '$($fontFile.Name)' installed successfully."
    }
}

# Clean up the temporary directory
Remove-Item -Path $tempDir -Recurse -Force
Write-Host "Hack Nerd Font installation process complete."


# 5. Copy files and directories
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

