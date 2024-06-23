param (
    [string]$version = "v0.1.0"
)

function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    Write-Host "Script not running as Administrator. Restarting with elevated privileges..."
    
    if ($PSVersionTable.PSEdition -eq "Core") {
        $shell = "pwsh"
    }
    else {
        $shell = "powershell"
    }

    Start-Process -FilePath $shell -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"" + $($MyInvocation.MyCommand.Path) + "`"") -Verb RunAs
    exit
}

$repo = "lukaszgasior/remove-branches"
$binName = "remove-branches"
$os = "Windows"
$arch = "x86_64"
$url = "https://github.com/$repo/releases/download/$version/${binName}_${os}_${arch}.zip"

$output = "$env:TEMP\$binName.zip"
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

