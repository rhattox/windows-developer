# Array of package IDs with optional versions
$packages = @(
    @{ Id = "Microsoft.VisualStudioCode";        Version = "" }
    @{ Id = "Docker.DockerDesktop";              Version = "" }
    @{ Id = "Google.Chrome";                     Version = "" }
    @{ Id = "7zip.7zip";                         Version = "" }
    @{ Id = "Logitech.GHUB";                     Version = "" }
    @{ Id = "VideoLAN.VLC";                      Version = "" }
    @{ Id = "git.git";                           Version = "" }
    @{ Id = "Insomnia.Insomnia";                 Version = "" }
    @{ Id = "Notepad++.Notepad++";               Version = "" }
    @{ Id = "Flameshot.Flameshot";               Version = "" }
    @{ Id = "Ditto.Ditto";                       Version = "" }
    @{ Id = "CPUID.HWMonitor";                   Version = "" }
    @{ Id = "qBittorrent.qBittorrent";           Version = "" }
    @{ Id = "JetBrains.IntelliJIDEA.Ultimate";   Version = "2025.2" }
    @{ Id = "JetBrains.Gateway";                 Version = "2025.2" }
)

foreach ($pkg in $packages) {
    $id = $pkg.Id
    $ver = $pkg.Version

    if ([string]::IsNullOrWhiteSpace($ver)) {
        Write-Host "Installing latest $id..." -ForegroundColor Cyan
        winget install --id $id --silent --accept-package-agreements --accept-source-agreements
    }
    else {
        Write-Host "Installing $id version $ver..." -ForegroundColor Cyan
        winget install --id $id --version $ver --silent --accept-package-agreements --accept-source-agreements
    }
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

winget install --id=DEVCOM.JetBrainsMonoNerdFont  -e



