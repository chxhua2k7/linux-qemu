@echo off
setlocal
chcp 65001

REM --- SSH Connection to FreeBSD in QEMU ---
echo 輸入使用者（root, 你設的名字，屁眼，…）
set /p USERNAME=
ssh -p 2222 "%USERNAME%"@localhost

pause
