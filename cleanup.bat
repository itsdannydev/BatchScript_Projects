@echo off
echo Cleaning temporary files...
REM del -> delete
REM /q -> quietly without asking for confirmation
REM /f -> force delete read only files
REM /s -> refers to all the subdirectories
REM rd -> remove directory ( del is not used as Recycle Bin is a special folder)

del /q/f/s %temp%\*
del /q/f/s C:\Windows\Temp\*
del /q/f/s C:\Windows\Prefetch\*
rd /s /q C:\$Recycle.Bin
echo Cleanup complete!
pause