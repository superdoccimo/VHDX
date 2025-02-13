#----------------------------------------------
# Script to automatically detect the WSL VHD file and, if it is already attached,
# detach it before executing diskpart to compact it.
#----------------------------------------------
# Please stop WSL beforehand (e.g., wsl --shutdown)
# Run PowerShell with administrative privileges

# Function to create and execute a temporary script for diskpart
function Invoke-DiskPartScript {
    param (
        [Parameter(Mandatory)]
        [string]$ScriptContent
    )
    # Create a random temporary filename
    $tempFile = Join-Path $env:TEMP ("dp_" + [System.IO.Path]::GetRandomFileName() + ".txt")
    try {
        # Write the temporary file using ASCII encoding
        $ScriptContent | Out-File -FilePath $tempFile -Encoding ascii
        Write-Host "Executing diskpart: $tempFile" -ForegroundColor Yellow
        # Capture and display the output from diskpart
        $result = diskpart /s $tempFile 2>&1
        Write-Host $result
    }
    finally {
        if (Test-Path $tempFile) {
            Remove-Item $tempFile -Force
        }
    }
}

try {
    # Recursively search for the ext4.vhdx path (for the Ubuntu package)
    $wslVhd = Get-ChildItem "$env:LOCALAPPDATA\Packages\*Ubuntu*\LocalState\ext4.vhdx" -Recurse -ErrorAction Stop | Select-Object -First 1

    if (-not $wslVhd) {
        throw "WSL VHD file not found. Please ensure the Ubuntu package is installed."
    }

    Write-Host "Found VHD file: $($wslVhd.FullName)" -ForegroundColor Green

    # ★ Since the VHD might already be attached, first attempt to detach it ★
    $detachScript = @"
select vdisk file="$($wslVhd.FullName)"
detach vdisk
"@

    Write-Host "Detaching the possibly attached VHD..." -ForegroundColor Yellow
    Invoke-DiskPartScript -ScriptContent $detachScript

    # Main process: attach (read-only) → compact → detach
    $compactScript = @"
select vdisk file="$($wslVhd.FullName)"
attach vdisk readonly
compact vdisk
detach vdisk
"@

    Write-Host "Executing compact operation with diskpart..." -ForegroundColor Yellow
    Invoke-DiskPartScript -ScriptContent $compactScript

    Write-Host "Operation completed successfully." -ForegroundColor Green

} catch {
    Write-Error "An error occurred: $_"
    exit 1
}