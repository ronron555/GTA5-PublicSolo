@echo off
setlocal
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

IF EXIST %UserProfile%\Scripts\ (
  cd %UserProfile%\Scripts
) ELSE (
  mkdir %UserProfile%\Scripts
  cd %UserProfile%\Scripts
)

IF %OS%==32BIT (
  IF NOT EXIST "C:\Program Files\7-Zip\7z.exe" (
    echo Downloading 7zip...
    curl https://www.7-zip.org/a/7z1900.exe --output 7z1900.exe
    cls
    echo Installing 7zip...
    start /wait 7z1900.exe /S
    del 7z1900.exe
  )
) ELSE (
  IF %OS%==64BIT (
    IF NOT EXIST "C:\Program Files\7-Zip\7z.exe" (
      echo Downloading 7zip...
      curl https://www.7-zip.org/a/7z1900-x64.exe --output 7z1900-x64.exe
      cls
      echo Installing 7zip...
      start /wait 7z1900-x64.exe /S
      del 7z1900-x64.exe
    )
  )
)

IF NOT EXIST %UserProfile%\Scripts\PSTools\ (
  echo Downloading PSTools...
  curl https://download.sysinternals.com/files/PSTools.zip --output PSTools.zip
  cls
  echo Unzipping PSTools...
  "C:\Program Files\7-Zip\7z.exe" e PSTools.zip -o%UserProfile%\Scripts\PSTools\
  del PSTools.zip
)
cls

echo Downloading The sendKeys Script...
curl https://raw.githubusercontent.com/npocmaka/batch.scripts/master/hybrids/jscript/sendKeys.bat --output sendKeys.bat
cls

echo Downloading The GTA5 Public-Solo Script...
curl https://raw.githubusercontent.com/ronron555/GTA5-PublicSolo/main/src/Public-Solo.bat --output GTA5-PublicSolo.bat
cls

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\GTA5 Public-Solo.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%UserProfile%\Scripts\GTA5-PublicSolo.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
