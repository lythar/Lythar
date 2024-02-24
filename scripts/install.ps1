# LYTHAR INSTALLATION SCRIPT
# This script is used to install Lythar on a new machine. It will install all the necessary software and tools to get started with Lythar.

$dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue

if ($null -eq $dockerInstalled) {
  Write-Host "Docker nie jest zainstalowany." -ForegroundColor Yellow
  Write-Host "Zainstaluj docker desktop z https://www.docker.com/products/docker-desktop (lub DockerCLI)" -ForegroundColor Yellow
  Write-Host "Naciśnij dowolny klawisz..." -ForegroundColor Yellow
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  exit
}

$dockerComposeInstalled = Get-Command docker-compose -ErrorAction SilentlyContinue

if ($null -eq $dockerComposeInstalled) {
  Write-Host "Docker Compose nie jest zainstalowany." -ForegroundColor Yellow
  Write-Host "Zainstaluj docker-compose z https://docs.docker.com/compose/install/" -ForegroundColor Yellow
  Write-Host "Naciśnij dowolny klawisz..." -ForegroundColor Yellow
  $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
  exit
}

$gitInstalled = Get-Command git -ErrorAction SilentlyContinue
$chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue

if ($null -eq $chocoInstalled) {
  Write-Host "Chocolatey nie jest zainstalowany. Instalowanie Chocolatey..." -ForegroundColor Green
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

if ($null -eq $gitInstalled && $null -ne $chocoInstalled) {
  Write-Host "Git nie jest zainstalowany. Instalowanie Git..." -ForegroundColor Green
  choco install git -y
}
elseif ($null -eq $gitInstalled && $null -eq $chocoInstalled) {
  Write-Host "Chocolatey nie jest zainstalowany. Instalowanie Chocolatey..." -ForegroundColor Green
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  Write-Host "Instalowanie Git..." -ForegroundColor Green
  choco install git -y
}

function CloneRepostiory {
  param (
    [string]$repo,
    [string]$path
  )

  if (-not (Test-Path -Path $path)) {
    Write-Host "Klonowanie repozytorium $repo do $path..." -ForegroundColor Green
    git clone $repo $path
  }
  else {
    Write-Host "Repozytorium $repo już istnieje w $path." -ForegroundColor Yellow
  }
}

$currentWorkingDirectory = Get-Location -PSProvider FileSystem

Write-Host "Klonowanie repozytoriów Lythar..." -ForegroundColor Green

CloneRepostiory "https://github.com/lythar/Lythar" "$currentWorkingDirectory\Lythar"
CloneRepostiory "https://github.com/lythar/lythar-frontend" "$currentWorkingDirectory\lythar-frontend"
CloneRepostiory "https://github.com/lythar/lythar-backend" "$currentWorkingDirectory\lythar-backend"

Write-Host "Kopiowanie przykładowych plików konfiguracyjnych..." -ForegroundColor Green
Copy-Item -Path "$currentWorkingDirectory\Lythar\scripts\example_secrets" -Destination "$currentWorkingDirectory\Lythar\secrets" -Recurse -Force

Write-Host "Usuwanie niepotrzebnych plików..." -ForegroundColor Green
Remove-Item -Path "$currentWorkingDirectory\Lythar\scripts" -Recurse -Force