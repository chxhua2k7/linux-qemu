@echo off

REM --- SSH Connection to FreeBSD in QEMU ---
echo Enter users (root, username, asshole)
set /p USERNAME=
ssh -p 2222 "%USERNAME%"@localhost

pause
