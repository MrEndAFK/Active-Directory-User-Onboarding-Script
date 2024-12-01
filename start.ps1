Import-Module ActiveDirectory


$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"
$Department = Read-Host "Enter Department"
$DefaultPassword = "Welcome2024!"


$Username = "$FirstName.$LastName".ToLower()
$Email = "$Username@company.com"



Try {
    New-ADUser -Name "$FirstName $LastName" `
               -GivenName $FirstName `
               -Surname $LastName `
               -SamAccountName $Username `
               -UserPrincipalName $Email `
               -Department $Department `
               -AccountPassword (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force) `
               -Enabled $true

    Write-Host "User $Username created successfully in department $Department" -ForegroundColor Green
} Catch {
    Write-Host "Failed to create user: $_" -ForegroundColor Red
    Exit
}

# Optional: Add user to department-specific group
$GroupName = "$Department-Group"
if (Get-ADGroup -Filter {Name -eq $GroupName}) {
    Try {
        Add-ADGroupMember -Identity $GroupName -Members $Username
        Write-Host "Added $Username to $GroupName" -ForegroundColor Cyan
    } Catch {
        Write-Host "Failed to add $Username to group ${GroupName}: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Group $GroupName not found. Skipping group membership..." -ForegroundColor Yellow
}

$LogFile = "C:\UserCreationLogs\log.txt"
Try {
    $LogEntry = "$Username | $Department | $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n"
    $LogEntry | Out-File -Append $LogFile
    Write-Host "Logged actions to $LogFile" -ForegroundColor Green
} Catch {
    Write-Host "Failed to log actions: $_" -ForegroundColor Red
}
