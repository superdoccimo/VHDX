# WSL VHD Compact Utility

This repository contains scripts that help compact the WSL (Windows Subsystem for Linux) VHD/VHDX file, which can grow over time. Two versions are available:

- PowerShell Script
- Batch Script

## ⚠️ Important Notice - January 2025 Update

**If you're experiencing issues after recent Windows updates, please see the [Troubleshooting](#troubleshooting) section below.**

Recent Windows updates (particularly those released in late 2024/early 2025) have changed PowerShell's execution policy and character encoding handling, which may prevent the scripts from running properly.

## Features

- **Automatic Detection**: Automatically locates the WSL VHD/VHDX file (e.g., ext4.vhdx) in common installation paths.
- **Safe Operation**: Checks if the VHD is already attached and detaches it if necessary.
- **Read-Only Attachment**: Attaches the VHD in read-only mode to ensure data integrity.
- **Automated Diskpart Integration**: Generates and executes a temporary diskpart script to perform the attach, compact, and detach operations.
- **Ease of Use**: Minimal configuration is required—simply run the script with administrative privileges after stopping WSL.

## Prerequisites

- **WSL Shutdown**: Before running the scripts, stop WSL by executing:
  ```bash
  wsl --shutdown
  ```
- **Administrator Privileges**: Ensure you run the scripts as an administrator.

## Supported OS

These scripts are intended for Windows systems running WSL.

## Usage

### PowerShell Script (Recommended Method)

1. **Open PowerShell as Administrator**.
2. Navigate to the repository directory.
3. **Set execution policy** (required after recent Windows updates):
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
4. Execute the script:
   ```powershell
   .\CompactWSLVHD.ps1
   ```

### Alternative PowerShell Method (Session-only)

If you prefer not to change the execution policy permanently:

1. **Open PowerShell as Administrator**.
2. Navigate to the repository directory.
3. Temporarily allow unsigned scripts (safe for session-only use):
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
4. Execute the script:
   ```powershell
   .\CompactWSLVHD.ps1
   ```

### Batch Script

Right-click the batch file (`CompactWSLVHD.bat`) and select "Run as administrator". Follow the on-screen instructions.

## Troubleshooting

### Issue: Script fails with parsing errors after Windows update

**Symptoms:**
- "UnexpectedToken" errors
- "Expression or statement token cannot be used" errors
- "Missing terminator" errors

**Cause:** Recent Windows updates have changed PowerShell's character encoding handling and execution policies.

**Solutions:**

#### Method 1: Fix Execution Policy (Most Common)
```powershell
# Run PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\CompactWSLVHD.ps1
```

#### Method 2: Re-save Script File
1. Open `CompactWSLVHD.ps1` in a text editor (Notepad, VS Code, etc.)
2. Save the file with **UTF-8 with BOM** encoding
3. Run the script again

#### Method 3: Direct Execution
```powershell
# If file encoding issues persist
Get-Content ".\CompactWSLVHD.ps1" -Encoding UTF8 | Invoke-Expression
```

### Issue: "Execution of scripts is disabled on this system"

**Solution:**
```powershell
# Check current policy
Get-ExecutionPolicy

# Set appropriate policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue: VHD file not found

**Solution:**
- Ensure WSL Ubuntu is installed and has been run at least once
- Check if the VHD path has changed after Windows updates
- Manually locate the ext4.vhdx file in `%LOCALAPPDATA%\Packages\`

## Changelog

### v1.1 (January 2025)
- **Fixed**: Compatibility with Windows updates from late 2024/early 2025
- **Updated**: Documentation with troubleshooting guide
- **Added**: Multiple execution methods for different user preferences
- **Improved**: Error handling and user guidance

### v1.0 (Initial Release)
- Initial PowerShell and Batch script implementation
- Automatic VHD detection and compacting functionality

## References

For additional details and context, please refer to these resources:

- **Blog:** [https://betelgeuse.work/wsl-diskpart/](https://betelgeuse.work/wsl-diskpart/)
- **Japanese Blog:** [https://minokamo.tokyo/2025/02/13/8446/](https://minokamo.tokyo/2025/02/13/8446/)
- **Hindi Blog:** [https://minokamo.in/wsl-vhdx](https://minokamo.in/wsl-vhdx)
- **YouTube:** [https://youtu.be/Gn4Pr03HtI](https://youtu.be/Gn4Pr03HtIo)
- **YouTube (Japanese):** [https://youtu.be/riZdxy7oFnM](https://youtu.be/riZdxy7oFnM)

## Contributing

If you encounter issues not covered in the troubleshooting section, please open an issue with:
- Your Windows version
- PowerShell version (`$PSVersionTable`)
- Complete error message
- Steps you've already tried