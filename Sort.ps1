$sourceFolder = Get-Location
$scriptName = $MyInvocation.MyCommand.Name

Get-ChildItem -Path $sourceFolder -File | ForEach-Object {
    $file = $_

    if ($file.Name -ieq $scriptName) {
        Write-Host "Skipping script file: $($file.Name)"
        return
    }

    $trimmedName = $file.Name.TrimStart()
    if ($trimmedName.Length -eq 0) {
        Write-Host "Skipping file with empty name after trim: $($file.Name)"
        return
    }

    $firstChar = $trimmedName.Substring(0,1).ToUpper()
    $targetFolder = if ($firstChar -match '[A-Z0-9]') { $firstChar } else { "_MISC" }
    $destinationFolder = Join-Path -Path $sourceFolder -ChildPath $targetFolder

    if (-not (Test-Path -Path $destinationFolder)) {
        Write-Host "Creating folder: $destinationFolder"
        New-Item -Path $destinationFolder -ItemType Directory | Out-Null
    }

    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name

    if (Test-Path -LiteralPath $destinationPath) {
        Write-Host "`nFile already exists: $($file.Name)"
        $choice = Read-Host "Choose: [S]kip, [O]verwrite, [R]ename"

        switch ($choice.ToUpper()) {
            "S" {
                Write-Host "Skipping file: $($file.Name)"
                return
            }
            "O" {
                Write-Host "Overwriting file: $($file.Name)"
                Move-Item -LiteralPath $file.FullName -Destination $destinationPath -Force
                return
            }
            "R" {
                $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                $ext = [System.IO.Path]::GetExtension($file.Name)
                $counter = 1
                do {
                    $newName = "$baseName ($counter)$ext"
                    $newDestinationPath = Join-Path -Path $destinationFolder -ChildPath $newName
                    $counter++
                } while (Test-Path -LiteralPath $newDestinationPath)

                Write-Host "Renaming to: $newName"
                Move-Item -LiteralPath $file.FullName -Destination $newDestinationPath
                return
            }
            default {
                Write-Host "Invalid choice. Skipping."
                return
            }
        }
    } else {
        Move-Item -LiteralPath $file.FullName -Destination $destinationFolder
        Write-Host "Moved: $($file.Name) → $targetFolder"
    }
}
