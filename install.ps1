param (
    [string]$version = "v0.1.0"
)

function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    Write-Host "This script needs to be run as an administrator. Exiting..."
    exit
}

$repo = "lukaszgasior/remove-branches"
$projectName = "remove-branches"
$binName = "git-remove-branches"
$os = "Windows"
$arch = "x86_64"
$url = "https://github.com/$repo/releases/download/$version/${projectName}_${version}_${os}_${arch}.zip"

$output = "$env:TEMP\$projectName.zip"
$binPath = "$env:ProgramFiles\Git\cmd"

Write-Host "Downloading $url"
Invoke-WebRequest -Uri $url -OutFile $output

Write-Host "Extracting $output"
Expand-Archive -Path $output -DestinationPath $env:TEMP -Force 

Write-Host "Installing $binName to $binPath"
Move-Item -Path "$env:TEMP\$binName.exe" -Destination $binPath -Force

Write-Host "Cleaning up"
Remove-Item -Path $output

Write-Host "Installation complete"

Write-Host "Press any key to continue..."
[System.Console]::ReadKey($true) > $null

