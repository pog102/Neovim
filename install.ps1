# Windows-specific installation script for Neovim configuration

# This script installs Neovim and the configuration files to the correct location on Windows.

# --- Configuration ---
# Check if running on Windows
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

# Check if ripgrep is installed, and install it if not
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Host "ripgrep not found. Attempting to install with winget..."
    try {
        winget install BurntSushi.ripgrep.MSVC --source winget --accept-source-agreements --accept-package-agreements
    } catch {
        Write-Error "Failed to install ripgrep with winget. Please install it manually."
    }
} else {
    Write-Host "ripgrep is already installed."
}

# Check if gcc is installed, and install it if not
if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
    Write-Host "gcc not found. Attempting to install with winget..."
    try {
        winget install MinGW.MinGW --source winget --accept-source-agreements --accept-package-agreements
    } catch {
        Write-Error "Failed to install gcc with winget. Please install it manually."
    }
} else {
    Write-Host "gcc is already installed."
}

# Check if node is installed, and install it if not
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js not found. Attempting to install with winget..."
    try {
        winget install OpenJS.NodeJS --source winget --accept-source-agreements --accept-package-agreements
    } catch {
        Write-Error "Failed to install Node.js with winget. Please install it manually."
    }
} else {
    Write-Host "Node.js is already installed."
}

# Set GITHUB_COPILOT_TOKEN environment variable from Secrets.txt
Write-Host "Checking for GITHUB_COPILOT_TOKEN environment variable..."
$tokenName = "GITHUB_COPILOT_TOKEN"
$tokenScope = "User"
$secretsFile = Join-Path $PSScriptRoot "Secrets.txt"

$existingToken = [System.Environment]::GetEnvironmentVariable($tokenName, $tokenScope)

if ($existingToken) {
    Write-Host "$tokenName is already set."
} else {
    if (Test-Path $secretsFile) {
        try {
            $secretsContent = Get-Content $secretsFile -ErrorAction Stop
            $tokenLine = $secretsContent | Where-Object { $_.Trim() -like "$tokenName=*" } | Select-Object -First 1
            
            if ($tokenLine) {
                $tokenValue = ($tokenLine -split '=', 2)[1].Trim()
                if ([string]::IsNullOrWhiteSpace($tokenValue)) {
                    Write-Warning "Found '$tokenName=' in $secretsFile but the value is empty. The environment variable was not set."
                } else {
                    Write-Host "Setting $tokenName from $secretsFile."
                    [System.Environment]::SetEnvironmentVariable($tokenName, $tokenValue, $tokenScope)
                    Write-Host "$tokenName has been set for the current user."
                    Write-Host "You may need to restart your terminal for the changes to take effect."
                }
            } else {
                Write-Warning "Could not find a line starting with '$tokenName=' in $secretsFile. The environment variable was not set."
            }
        } catch {
            Write-Error "Failed to read $secretsFile or set the environment variable. Error: $_"
        }
    } else {
        Write-Warning "$secretsFile not found. The GITHUB_COPILOT_TOKEN environment variable was not set."
        Write-Warning "Please create 'Secrets.txt' in the same directory as this script with the content: GITHUB_COPILOT_TOKEN=your_token_here"
    }
}


if (-not (Test-Path -Path $destinationDir)) {
    Write-Host "Creating destination directory: $destinationDir"
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}

# 4. Install Fira Code Nerd Font
Write-Host "Checking for Fira Code Nerd Font..."
# We check for a specific font file that is included in the Fira Code Nerd Font package.
$fontCheckFile = "Hack Nerd Font.ttf"
if (Test-Path -Path "$($env:windir)\Fonts\$fontCheckFile") {
    Write-Host "Fira Code Nerd Font appears to be already installed."
} else {
    Write-Host "Installing Fira Code Nerd Font..."
    $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
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



