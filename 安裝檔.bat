@echo off

:: --- Get this folder of .bat file ---
set SCRIPT_DIR=%~dp0
set QEMU_PATH=C:\Program Files\qemu

:: --- Some Path file ---
set IMG_PATH=%SCRIPT_DIR%freebsd.img
set ISO_PATH=%SCRIPT_DIR%FreeBSD-14.3-RELEASE-amd64-bootonly.iso
set ISO_URL=https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/14.3/FreeBSD-14.3-RELEASE-amd64-bootonly.iso

cd /d "%QEMU_PATH%"

:: --- If ISO is not, download it ---
if not exist "%ISO_PATH%" (
    echo === ISO file not found, downloading... ===
    powershell -Command "Invoke-WebRequest -Uri '%ISO_URL%' -OutFile '%ISO_PATH%'"
    if exist "%ISO_PATH%" (
        echo Downloaded %ISO_PATH%
    ) else (
        echo Error: Cannot download, do it youserf
	    echo FreeBSD ISO Links: %ISO_URL%
        pause
        exit /b
    )
) else (
    echo ISO file is here %ISO_PATH%
)

:: --- Size of IMG file ---
echo Enter freebsd.img file (Example: 8G, 16G, 64G, 696G,…)
set /p IMG_SIZE=  

:: --- Create IMG file ---
echo Creating freebsd.img file, the size is %IMG_SIZE%...
qemu-img.exe create -f raw "%IMG_PATH%" %IMG_SIZE%

:: --- Run QEMU to install ---
echo Starting QEMU...
qemu-system-x86_64.exe -m 1024 -cdrom "%ISO_PATH%" -boot d -drive file="%IMG_PATH%",format=raw -net nic -net user

pause
