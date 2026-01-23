# Windows-specific installation script for Neovim configuration

# This script installs Neovim and the configuration files to the correct location on Windows.

# Source directory (where this script is located)
$sourceDir = $PSScriptRoot

# Destination directory for Neovim configuration on Windows
$destinationDir = "$env:LOCALAPPDATA\nvim"

# Files and directories to exclude from copying
$exclude = @(
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

# Check if Git is installed, and install it if not
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git not found. Attempting to install with winget..."
    try {
        winget install Git.Git --source winget --accept-source-agreements --accept-package-agreements
    } catch {
        Write-Error "Failed to install Git with winget. Please install it manually."
        exit 1
    }
} else {
    Write-Host "Git is already installed."
}

# Check if Lazygit is installed, and install it if not
if (-not (Get-Command lazygit -ErrorAction SilentlyContinue)) {
    Write-Host "Lazygit not found. Attempting to install with winget..."
    try {
        winget install JesseDuffield.lazygit --source winget --accept-source-agreements --accept-package-agreements
    } catch {
        Write-Error "Failed to install Lazygit with winget. Please install it manually."
    }
} else {
    Write-Host "Lazygit is already installed."
}

if (-not (Test-Path -Path $destinationDir)) {
    Write-Host "Creating destination directory: $destinationDir"
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}

# 4. Install Fira Code Nerd Font
Write-Host "Checking for Fira Code Nerd Font..."
# We check for a specific font file that is included in the Fira Code Nerd Font package.
$fontCheckFile = "Fira Code Regular Nerd Font Complete.ttf"
if (Test-Path -Path "$($env:windir)\Fonts\$fontCheckFile") {
    Write-Host "Fira Code Nerd Font appears to be already installed."
} else {
    Write-Host "Installing Fira Code Nerd Font..."
    $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
    $tempDir = "$env:TEMP\FiraCodeNerdFont"
    $fontZipPath = "$tempDir\FiraCode.zip"

    # Create a temporary directory for the font download
    if (-not (Test-Path -Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir | Out-Null
    }

    # Download the font zip file
    try {
        Invoke-WebRequest -Uri $fontZipUrl -OutFile $fontZipPath
        Write-Host "Downloaded Fira Code Nerd Font."
    } catch {
        Write-Error "Failed to download Fira Code Nerd Font. Please install it manually from $fontZipUrl"
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
    Write-Host "Fira Code Nerd Font installation process complete."
}


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

# 6. Set PowerShell alias for nvim
Write-Host "Setting up PowerShell alias 'n' for 'nvim'..."

# Check if the profile file exists, create if it doesn't
if (-not (Test-Path -Path $PROFILE)) {
    Write-Host "PowerShell profile not found. Creating one at: $PROFILE"
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# Check if the alias is already in the profile
# We use -match to check for the presence of the alias command.
$profileContent = Get-Content -Path $PROFILE -ErrorAction SilentlyContinue
$aliasCommand = "Set-Alias -Name n -Value nvim"
if ($profileContent -match [regex]::Escape($aliasCommand)) {
    Write-Host "Alias 'n' for 'nvim' for 'nvim' already exists in the PowerShell profile."
} else {
    Write-Host "Adding alias 'n' for 'nvim' to the PowerShell profile."
    Add-Content -Path $PROFILE -Value "`n# Alias for Neovim`n$aliasCommand"
    Write-Host "Alias added. Please restart your PowerShell session for the changes to take effect."
}


