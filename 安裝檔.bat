@echo off
setlocal
chcp 65001

REM --- Get this folder of .bat file ---
set SCRIPT_DIR=%~dp0
set QEMU_PATH=C:\Program Files\qemu

REM --- Some Path file ---
set IMG_PATH=%SCRIPT_DIR%freebsd.img
set ISO_PATH=%SCRIPT_DIR%FreeBSD-14.3-RELEASE-amd64-bootonly.iso
set ISO_URL=https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/14.3/FreeBSD-14.3-RELEASE-amd64-bootonly.iso

cd /d "%QEMU_PATH%"

REM --- If ISO is not, download it ---
if not exist "%ISO_PATH%" (
    echo === 找不到ISO檔，幫你下載... ===
    powershell -Command "Invoke-WebRequest -Uri '%ISO_URL%' -OutFile '%ISO_PATH%'"
    if exist "%ISO_PATH%" (
        echo 下載成功：%ISO_PATH%
    ) else (
        echo 錯誤：無法下載，自己去下載吧！
	    echo 連結： %ISO_URL%
        pause
        exit /b
    )
) else (
    echo ISO檔已存在：%ISO_PATH%
)

REM --- Size of IMG file ---
echo 輸入freebsd.img檔容量大小（例如：8G, 16G, 64G, 696G,…）
set /p IMG_SIZE=  

REM --- Create IMG file ---
echo 正在創freebsd.img檔，容量 %IMG_SIZE%...
qemu-img.exe create -f raw "%IMG_PATH%" %IMG_SIZE%

REM --- Run QEMU to install ---
echo 正在啟動QEMU...
qemu-system-x86_64.exe -m 1024 -cdrom "%ISO_PATH%" -boot d -drive file="%IMG_PATH%",format=raw -net nic -net user

echo --------------------------------------
echo 安裝完後，記得按啟動檔！
echo 後面自己加油，幫不了了♪(´ε｀ )
echo --------------------------------------
pause
