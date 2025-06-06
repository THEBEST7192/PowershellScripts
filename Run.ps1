# Get the current script's directory
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent

# Get all .ps1 files in the current directory
$scripts = Get-ChildItem -Path $scriptDir -Filter *.ps1

# Check if any scripts were found
if ($scripts.Count -eq 0) {
    Write-Host "No PowerShell scripts found in this directory."
    return
}

# Display the list of scripts with numbers
Write-Host "Available PowerShell scripts:"
for ($i = 0; $i -lt $scripts.Count; $i++) {
    Write-Host "$($i + 1). $($scripts[$i].Name)"
}

# Prompt the user to select a script
while ($true) {
    $selection = Read-Host "Enter the number of the script to run, 'i' to view info, or 'q' to quit"

    if ($selection -eq "q") {
        break
    }

    # Show info about the script
    if ($selection -match "^i\s*(\d+)$") {
        $infoIndex = [int]$Matches[1] - 1
        if ($infoIndex -ge 0 -and $infoIndex -lt $scripts.Count) {
            $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($scripts[$infoIndex].Name)
            $infoPath = Join-Path $scriptDir "$scriptName.md"
            if (Test-Path $infoPath) {
                Write-Host "`n--- INFO for $($scripts[$infoIndex].Name) ---`n"
                Get-Content $infoPath | Out-Host
                Write-Host "`n--- END OF INFO ---`n"
            } else {
                Write-Host "No info file ($scriptName.md) found for this script."
            }
        } else {
            Write-Host "Invalid index for info. Try 'i 1' or 'i 2', etc."
        }
        continue
    }

    # Execute the script
    if ($selection -match "^\d+$") {
        $scriptIndex = [int]$selection - 1
        if ($scriptIndex -ge 0 -and $scriptIndex -lt $scripts.Count) {
            $selectedScript = $scripts[$scriptIndex]
            Write-Host "Running $($selectedScript.Name)..."
            try {
                & $selectedScript.FullName
            } catch {
                Write-Host "Error running script: $($_.Exception.Message)"
            }
            break
        } else {
            Write-Host "Invalid selection. Please enter a number from the list."
        }
    } else {
        Write-Host "Invalid input. Use a number to run, 'i #' to view info, or 'q' to quit."
    }
}
