<powershell>
#Alterar TimeZone para America Padrão
C:\Windows\System32\tzutil /s "E. South America Standard Time"

# Instalação do Git
Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.2/Git-2.33.0.2-64-bit.exe" -OutFile "$env:TEMP\git_installer.exe"
Start-Process -FilePath "$env:TEMP\git_installer.exe" -ArgumentList "/SILENT" -Wait

# Instalar o Chocolatey (se ainda não estiver instalado)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Instalar 
choco install vscode -y
Set-Location "C:\Windows\system32"

# Instalar o Python usando Chocolatey
choco install python -y
Set-Location "C:\Windows\system32"

#Install Chrome 
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile     $Path\$Installer; 
Start-Process -FilePath $Path\$Installer -ArgumentList "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

#Set Chrome as default browser
$chromePath = "$${Env:ProgramFiles(x86)}\Google\Chrome\Application\" 
$chromeApp = "chrome.exe"
$chromeCommandArgs = "--make-default-browser"
& "$chromePath$chromeApp" $chromeCommandArgs
</powershell>