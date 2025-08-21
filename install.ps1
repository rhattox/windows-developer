# Array of package IDs from winget
$packages = @(
    "Microsoft.VisualStudioCode",
    "Docker.DockerDesktop",
    "Google.Chrome",
    "7zip.7zip",
    "Logitech.GHUB",
    "Insomnia.Insomnia",
    "Notepad++.Notepad++",
    "JetBrains.IntelliJIDEA.Ultimate",
    "Flameshot.Flameshot",
    "Ditto.Ditto",
    "CPUID.HWMonitor"

)

foreach ($pkg in $packages) {
    Write-Host "Installing $pkg..." -ForegroundColor Cyan
    winget install --id $pkg --silent --accept-package-agreements --accept-source-agreements
}



Stop-Service -Name "WSearch" -Force
Set-Service -Name "WSearch" -StartupType Disabled

# Run this script as Administrator

Write-Host "Enabling WSL and Virtual Machine features..." -ForegroundColor Cyan
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Setting WSL 2 as the default version..." -ForegroundColor Cyan
wsl --set-default-version 2

Write-Host "Installing Debian distribution..." -ForegroundColor Cyan
wsl --install -d Debian

Write-Host "Installation complete. Please restart your computer if prompted." -ForegroundColor Green


reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
