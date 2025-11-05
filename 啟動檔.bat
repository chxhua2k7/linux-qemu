@echo off

REM --- Get this folder ---
set SCRIPT_DIR=%~dp0
set QEMU_PATH=C:\Program Files\qemu
set IMG_PATH=%SCRIPT_DIR%freebsd.img

cd /d "%QEMU_PATH%"

REM --- Looking for file img ---
if not exist "%IMG_PATH%" (
    echo Error: "%IMG_PATH%" not found.
    pause
    exit /b
)

echo === Start FreeBSD ===
qemu-system-x86_64.exe -cpu max -m 2G -smp 2 -drive file="%IMG_PATH%",if=virtio,format=raw -device virtio-net-pci,netdev=n0 -netdev user,id=n0,hostfwd=tcp:127.0.0.1:2222-:22,hostfwd=tcp:127.0.0.1:8080-:8080 -display gtk

pause
