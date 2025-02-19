# WSL VHD Compact Utility

This repository contains scripts that help compact the WSL (Windows Subsystem for Linux) VHD/VHDX file, which can grow over time. Two versions are available:
- PowerShell Script
- Batch Script

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
## Administrator Privileges:
Ensure you run the scripts as an administrator.

## Supported OS:
These scripts are intended for Windows systems running WSL.

## Usage

### PowerShell Script
- Open PowerShell as an administrator.
- Navigate to the repository directory.
- Execute the script:
  ```powershell
  .\CompactWSLVHD.ps1
  ```
## Batch Script

Right-click the batch file (`CompactWSLVHD.bat`) and select "Run as administrator".  
Follow the on-screen instructions.

## References

For additional details and context, please refer to these resources:

- **Blog:** [https://showa.fun/wsl-diskpart](https://showa.fun/wsl-diskpart)
- **Japanese Blog:** [https://minokamo.tokyo/2025/02/13/8446/](https://minokamo.tokyo/2025/02/13/8446/)
- **Hindi Blog:** [https://minokamo.in/wsl-vhdx](https://minokamo.in/wsl-vhdx)
- **YouTube:** [https://youtu.be/Gn4Pr03HtIo](https://youtu.be/Gn4Pr03HtIo)
- **YouTube (Japanese):** [https://youtu.be/riZdxy7oFnM](https://youtu.be/riZdxy7oFnM)