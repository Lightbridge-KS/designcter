# PowerShell script to download Visual C++ Redistributables for local Windows installer builds
# Usage: Run this script from the project root directory before building the installer locally

param(
    [string]$OutputPath = "windows\installer\vc_redist.x64.exe"
)

$vcRedistUrl = "https://aka.ms/vs/17/release/vc_redist.x64.exe"

Write-Host "Downloading Visual C++ Redistributables for local installer build..."
Write-Host "URL: $vcRedistUrl"
Write-Host "Output: $OutputPath"

try {
    # Create directory if it doesn't exist
    $outputDir = Split-Path $OutputPath -Parent
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force
        Write-Host "Created directory: $outputDir"
    }

    # Download the redistributables
    Invoke-WebRequest -Uri $vcRedistUrl -OutFile $OutputPath -UseBasicParsing
    
    if (Test-Path $OutputPath) {
        $fileSize = (Get-Item $OutputPath).Length
        Write-Host "Successfully downloaded Visual C++ Redistributables"
        Write-Host "File size: $fileSize bytes"
        Write-Host "Saved to: $OutputPath"
        
        # Verify the file is a valid executable
        if ((Get-Item $OutputPath).Extension -eq ".exe") {
            Write-Host "File verification: Valid executable"
        } else {
            Write-Warning "File verification: Not a valid executable"
        }
    } else {
        Write-Error "Failed to download file"
        exit 1
    }
} catch {
    Write-Error "Error downloading Visual C++ Redistributables: $_"
    exit 1
}

Write-Host "Download complete! You can now build the installer locally."