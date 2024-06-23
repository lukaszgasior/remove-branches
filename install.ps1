param (
    [string]$version = "v0.1.0"
)

$repo = "lukaszgasior/remove-branches"
$binName = "git-remove-branches"
$os = "Windows"
$arch = "x86_64"
$url = "https://github.com/$repo/releases/download/$version/${binName}_${os}_${arch}.zip"

$output = "$env:TEMP\$binName.zip"
$binPath = "$env:ProgramFiles\Git\bin"

Write-Host "Downloading $url"
Invoke-WebRequest -Uri $url -OutFile $output

Write-Host "Extracting $output"
Expand-Archive -Path $output -DestinationPath $env:TEMP

Write-Host "Installing $binName to $binPath"
Move-Item -Path "$env:TEMP\$binName.exe" -Destination $binPath -Force

Write-Host "Cleaning up"
Remove-Item -Path $output

Write-Host "Installation complete"

