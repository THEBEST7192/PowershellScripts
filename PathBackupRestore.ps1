function Backup-Path {
    param (
        [ValidateSet("User","Machine")]
        [string]$Scope
    )
    $enumScope = [System.EnvironmentVariableTarget]::$Scope
    $pathValue = [Environment]::GetEnvironmentVariable("Path", $enumScope)
    $backupFile = Read-Host "Enter full file path to save the backup (e.g. C:\path_backup.txt)"
    try {
        $pathValue | Out-File -FilePath $backupFile -Encoding UTF8
        Write-Host "$Scope PATH backed up successfully to :) : $backupFile"
    }
    catch {
        Write-Host "Failed to backup PATH :( : $_"
    }
}

function Restore-Path {
    param (
        [ValidateSet("User","Machine")]
        [string]$Scope
    )
    $enumScope = [System.EnvironmentVariableTarget]::$Scope
    $restoreFile = Read-Host "Enter full file path to restore from (e.g. C:\path_backup.txt)"
    if (-Not (Test-Path $restoreFile)) {
        Write-Host "File not found :( : $restoreFile"
        return
    }
    try {
        $content = Get-Content -Path $restoreFile -Raw
        [Environment]::SetEnvironmentVariable("Path", $content.Trim(), $enumScope)
        Write-Host "$Scope PATH restored successfully from $restoreFile :)"
    }
    catch {
        Write-Host "Failed to restore PATH :( ): $_"
    }
}


function Show-Menu {
    Clear-Host
    Write-Host "=== PATH Backup & Restore Utility ===" -ForegroundColor Cyan
    Write-Host "Choose an option:"
    Write-Host "1) Backup USER PATH"
    Write-Host "2) Backup SYSTEM PATH (requires admin)"
    Write-Host "3) Restore USER PATH"
    Write-Host "4) Restore SYSTEM PATH (requires admin)"
    Write-Host "5) Exit"
}

do {
    Show-Menu
    $choice = Read-Host "Enter choice [1-5]"
    switch ($choice) {
        '1' { Backup-Path -Scope User }
        '2' { Backup-Path -Scope Machine }   # ← FIXED
        '3' { Restore-Path -Scope User }
        '4' { Restore-Path -Scope Machine }  # ← FIXED
        '5' { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid choice, try again." }
    }

    Write-Host ""
    Pause
} while ($true)
