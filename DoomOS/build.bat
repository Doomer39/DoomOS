@echo off

echo Assembling bootloader...
nasm bootloader/bootloader.asm -f bin -o bootloader.bin
if errorlevel 1 goto error

echo Assembling kernel...
nasm kernel/kernel.asm -f bin -o kernel.bin
if errorlevel 1 goto error

echo Creating disk image...
copy /b bootloader.bin+kernel.bin DoomOS_0.1.img >nul
if errorlevel 1 goto error

echo.
echo Build successful!
echo Output: DoomOS_0.1.img
goto end

:error
echo.
echo Build failed!
pause

:end