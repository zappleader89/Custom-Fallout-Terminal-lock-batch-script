@echo off

color a
SETLOCAL EnableDelayedExpansion
setlocal
set /a curbest=10

:newgame
set loop=0
:loop
  set /a cur=0
  set /a num=%RANDOM%%%100+1
  set /a rand=%RANDOM% %%100+1
  set /a sand=%RANDOM% %%100+1
  set left=1
  set right=100

echo    0xF437       %rand%    0x274        %random%    0x683        %sand%    0x386         %num%    0x684        %random%
set /a loop=%loop%+1 
if "%loop%"=="13" goto loopse
goto loop

:loopse
set loops=0
:loops
echo   0xF437       37    0x274        %random%    0x386         43    0x683            73    0x684        %random%
echo   0xF437       31    0x274        %random%    0x386         94    0x683            68    0x684        %random%
echo   0xF437       95    0x274        %random%    0x386         58    0x683            46    0x684        %random%
set /a loops=%loops%+1
if "%loops%"=="3" goto repeat
goto loops

:Repeat
  if %cur% EQU 11 goto bad else goto ask
    set /p guess=Please guess[%left%,%right%]:
    set /a cur=cur+1
    if %guess% EQU %num% (
      echo You have guessed %cur% times to unlock!
      if %cur% EQU 11 goto bad else goto unlock
       goto unlock
    )
    if %guess% LSS %num% (
      echo wrong! Higher guess number %cur%
      set /a left=%guess%+1
      goto repeat
    )
    echo Wrong! Lower guess number %cur%
    set /a right=%guess%-1
    goto repeat
    if %guess% EQU %rand% (
      echo You have guessed %cur% times to unlock!
      if %cur% EQU 11 goto bad else goto unlock
       goto unlock
    if %guess% EQU %sand% (
      echo You have guessed %cur% times to unlock!
      if %cur% EQU 11 goto bad else goto unlock
       goto unlock
:unlock
  choice /c:yn /n /m "Do you want to unlock?"
  if %errorlevel% EQU 1 goto bye else goto end

:bye
cls
  echo Unlocking...
  if not %curbest% EQU 10 echo you guessed  %curbest% times
pause
start saved.bat
goto end

endlocal

:bad
cls
echo You guessed more than 10 times!
pause
goto end
:end
