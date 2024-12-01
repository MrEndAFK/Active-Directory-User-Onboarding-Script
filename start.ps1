if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Host "The ActiveDirectory module is not installed. Please install it before running the script." -ForegroundColor Red
    Exit
}

Import-Module ActiveDirectory

$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"
$Department = Read-Host "Enter Department"
$Email = Read-Host "Enter Email Address (leave blank to auto-generate)"

Function Generate-Password {
    param (
        [int]$Length = 12
    )
    Add-Type -AssemblyName System.Web
    [System.Web.Security.Membership]::GeneratePassword($Length, 2)
}

$DefaultPassword = Generate-Password
Write-Host "Generated default password: $DefaultPassword" -ForegroundColor Yellow

if ([string]::IsNullOrWhiteSpace($FirstName) -or 
    [string]::IsNullOrWhiteSpace($LastName) -or 
    [string]::IsNullOrWhiteSpace($Department)) {
    Write-Host "Error: First Name, Last Name, and Department must be provided." -ForegroundColor Red
    Exit
}

if ([string]::IsNullOrWhiteSpace($Email)) {
    $Email = "$FirstName.$LastName@company.com"
    Write-Host "No email entered. Defaulting to: $Email" -ForegroundColor Yellow
} elseif ($Email -notmatch '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') {
    Write-Host "Invalid email format. Please rerun the script and enter a valid email." -ForegroundColor Red
    Exit
}

$Username = "$FirstName.$LastName".ToLower()

Try {
    New-ADUser -Name "$FirstName $LastName" `
               -GivenName $FirstName `
               -Surname $LastName `
               -SamAccountName $Username `
               -UserPrincipalName $Email `
               -Department $Department `
               -AccountPassword (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force) `
               -Enabled $true

    Write-Host "User $Username created successfully in department $Department with email $Email" -ForegroundColor Green
} Catch {
    Write-Host "Failed to create user: $_" -ForegroundColor Red
    Exit
}

$LogFile = "C:\UserCreationLogs\log.txt"
if (-not (Test-Path "C:\UserCreationLogs")) {
    New-Item -ItemType Directory -Path "C:\UserCreationLogs" | Out-Null
}

Try {
    $LogEntry = "$Username,$Email,$Department,$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $LogEntry | Out-File -Append $LogFile
    Write-Host "Logged actions to $LogFile" -ForegroundColor Green
} Catch {
    Write-Host "Failed to log actions: $_" -ForegroundColor Red
}
