@echo off
cd %UserProfile%\Scripts\PSTools
cls
echo Suspending GTA5.exe process...
pssuspend.exe GTA5.exe > nul
cls
echo GTA5.exe process paused...
echo Waiting 10 seconds...
ping 127.0.0.1 -n 11 > nul
cls
echo Resuming GTA5.exe process..
pssuspend.exe -r GTA5.exe > nul
cd  %UserProfile%\Scripts
call sendkeys.bat "Grand Theft Auto V" ""
