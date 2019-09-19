setlocal EnableDelayedExpansion
set "countmaintainers=findstr /R /N "^^" P:\SCI_CHAT\maintainers.txt | find /C ":""
set "verifyunique=findstr /R /N "^^" P:\SCI_CHAT\verifyunique.txt | find /C ":""

:restart

set MaintainerID=%RANDOM%
set TakeOverOriginal=3
set BrokenOriginal=5
set AloneOriginal=2
set DelayBonusOriginal=1
set ObserveRoundsOriginal=10
set IDresetNeedOriginal=10
set maintainers=1
set RegisterRoundsOriginal=2
set first=false

set TakeOver=%TakeOverOriginal%
set CurrentMaintainer=Initialized
set PreviousMaintainer=Initialize
set Broken=%BrokenOriginal%
set Alone=%AloneOriginal%
set DelayBonus=%DelayBonusOriginal%
set ObserveRounds=%ObserveRoundsOriginal%
set IDresetNeed=%IDresetNeedOriginal%
set RegisterRounds=%RegisterRoundsOriginal%
set unique=init
set ChatText=text

:start

if exist P:\SCI_CHAT\maintainers.txt (for /f %%a in ('!countmaintainers!') do set maintainers=%%a)
set /A CheckDelay=%RANDOM% * 10 / 32768 + 30 + (10 * %maintainers%)

if exist P:\SCI_CHAT\maintainer.txt ( echo maintainer file exists ) else ( goto NoDoesNot )
	set /A TakeOver=(%TakeOver%-1)
	for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
	if "%CurrentMaintainer%"=="%PreviousMaintainer%" ( set TakeOver=%TakeOverOriginal%)
	if "%CurrentMaintainer%"=="%MaintainerID% " ( set /A Alone=%Alone%-1) else (set Alone=%AloneOriginal%)
	set PreviousMaintainer=%CurrentMaintainer%
	if "%CurrentMaintainer%"=="NEWMAINTAINER " (set TakeOver=%TakeOverOriginal%) else (echo %MaintainerID% > P:\SCI_CHAT\maintainer.txt)
	if "%CurrentMaintainer%"=="NEWMAINTAINER " (set /A Broken=%Broken%-1) else (set Broken=%BrokenOriginal%)
	if %Broken%== 0 (echo %MaintainerID% > P:\SCI_CHAT\maintainer.txt)
	if %TakeOver% == 0 ( goto goActive )
	if %Alone% == 0 ( goto goActive )
	if %RegisterRounds% == 2 (echo %MaintainerID% >> P:\SCI_CHAT\maintainers.txt)
	if %RegisterRounds% == 0 (echo > P:\SCI_CHAT\maintainers.txt)
	if %RegisterRounds% == 0 (set /A RegisterRounds=%RegisterRoundsOriginal%)
	title Maintainer %MaintainerID% (%TakeOver%/%Broken%/%Alone%/%RegisterRounds%) - maintainers aprox.: %maintainers%
	set /A RegisterRounds=%RegisterRounds%-1
	timeout /nobreak %CheckDelay%
	goto start
:NoDoesNot

if not exist P:\SCI_CHAT\maintainer.txt ( echo maintainer file doesn't exist ) else (goto YesDoes)
	if not exist P:\SCI_CHAT\ ( mkdir P:\SCI_CHAT\ )
	echo %MaintainerID% > P:\SCI_CHAT\maintainer.txt
	timeout /nobreak %CheckDelay%
	goto start
:YesDoes


goto start

set ObserveRounds=%ObserveRoundsOriginal%

goto start

:goActive
set /A TakeOver=100
:announce
title Maintainer %MaintainerID% ANNOUNCING SELECTION...%TakeOver%
echo NEWMAINTAINER > P:\SCI_CHAT\maintainer.txt
timeout /nobreak 1
set /A TakeOver=%TakeOver%-1
if "%TakeOver%"=="0" (set TakeOver=10) else ( goto announce )
:maintain
timeout /nobreak 2
echo %MaintainerID% > P:\SCI_CHAT\maintainer.txt
if exist P:\SCI_CHAT\maintainers.txt (for /f %%a in ('!countmaintainers!') do set maintainers=%%a)
title Maintainer %MaintainerID% MAINTAINING %TakeOver% (Stability = %Broken%/%BrokenOriginal%) maintainers aprox.: %maintainers%
set /A TakeOver=%TakeOver%-1
if "%TakeOver%"=="0" (set TakeOver=10) else (goto maintain)
if "%TakeOver%"=="10" (goto checkBroken)







goto maintain

:checkBroken
if exist P:\SCI_CHAT\verifyunique.txt (for /f %%a in ('!verifyunique!') do set unique=%%a)
if %unique% == 1 (echo %MaintainerID% >> P:\SCI_CHAT\verifyunique.txt ) else (set /A Broken=%Broken%-1)
echo %uniue%
timeout /nobreak 5
for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
if "%CurrentMaintainer%"=="%MaintainerID% " (set Broken=%BrokenOriginal%) else (set /A Broken=%Broken%-1)
echo %MaintainerID% > P:\SCI_CHAT\verifyunique.txt
if %Broken%== 0 (goto restart)
goto maintain