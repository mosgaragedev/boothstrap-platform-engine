Write-Host "🚀 Starting WSL Enterprise Bootstrap..."

# Ensure WSL
wsl --install

Start-Sleep -Seconds 5

# Paths
$DistroName = "EnterpriseWSL"
$InstallPath = "C:\WSL\EnterpriseWSL"
$TarPath = ".\rootfs.tar"

# Import distro
wsl --import $DistroName $InstallPath $TarPath --version 2

# Initial setup inside WSL
wsl -d $DistroName -- bash -c "
set -e
echo '[+] Updating system...'
apt update && apt upgrade -y

echo '[+] Installing core tooling...'
apt install -y podman git curl vim gh direnv

echo '[+] Installing DevPod...'
curl -L https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64 -o /usr/local/bin/devpod
chmod +x /usr/local/bin/devpod

echo '[+] Installing Azure CLI...'
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

echo '[+] Creating workspace...'
mkdir -p /workspace/{projects,shared,restricted,mosgarage}

echo '[✓] Bootstrap complete'
"

Write-Host "✅ Environment ready. Launch with: wsl -d $DistroName"
