mode con: cols=120 lines=2
pushd P:\

setlocal EnableDelayedExpansion
set "countmaintainers=findstr /R /N "^^" P:\SCI_CHAT\maintainers.txt | find /C ":""
set "verifyunique=findstr /R /N "^^" P:\SCI_CHAT\verifyunique.txt | find /C ":""

set "countlowtext=findstr /R /N "^^" P:\SCI_CHAT\lowtext.txt | find /C ":""
set "countmidtext=findstr /R /N "^^" P:\SCI_CHAT\midtext.txt | find /C ":""
set "counthightext=findstr /R /N "^^" P:\SCI_CHAT\hightext.txt | find /C ":""



:restart

set MaintainerID=%RANDOM%
set TakeOverOriginal=3
set BrokenOriginal=5
set AloneOriginal=2
set DelayBonusOriginal=1
set ObserveRoundsOriginal=10
set IDresetNeedOriginal=10
set maintainers=2
set RegisterRoundsOriginal=1
set first=false
set UnoriginalOriginal=10

set "min.size=120"
set lowtext=0
set midtext=0
set hightext=0

set TakeOver=%TakeOverOriginal%
set CurrentMaintainer=Initialized
set PreviousMaintainer=Initialize
set Broken=%BrokenOriginal%
set Alone=%AloneOriginal%
set DelayBonus=%DelayBonusOriginal%
set ObserveRounds=%ObserveRoundsOriginal%
set /A OriginalRounds=%ObserveRoundsOriginal% / 2
set IDresetNeed=%IDresetNeedOriginal%
set RegisterRounds=%RegisterRoundsOriginal%
set unique=init
set ChatText=text
set Unoriginal=%UnoriginalOriginal%
set RandomRegister=-1
set failboost=0
set VerifiedMaintainer=iinii
:start

if exist P:\SCI_CHAT\maintainers.txt (for /f %%a in ('!countmaintainers!') do set maintainers=%%a)
set /A CheckDelay=%RANDOM% * 10 / 32768 + 15
set /A RandomRegister=(%RANDOM% * %maintainers% * 100) / 32768

	if not exist P:\SCI_CHAT\INBOX ( mkdir P:\SCI_CHAT\INBOX\ )

if exist P:\SCI_CHAT\maintainer.txt ( echo maintainer file exists ) else ( goto NoDoesNot )
	set /A TakeOver=(%TakeOver%-1)
	for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
	if "%CurrentMaintainer%"=="%PreviousMaintainer%" ( set TakeOver=%TakeOverOriginal%)
	if "%CurrentMaintainer%"=="%MaintainerID% " ( set /A Alone=%Alone%-1) else (set Alone=%AloneOriginal%)
	set PreviousMaintainer=%CurrentMaintainer%
	if "%CurrentMaintainer%"=="NEWMAINTAINER " (set TakeOver=%TakeOverOriginal%) else (echo %MaintainerID% > P:\SCI_CHAT\maintainer.txt)
	if "%CurrentMaintainer%"=="NEWMAINTAINER " (set /A Broken=%Broken%-1) else (set Broken=%BrokenOriginal%)
	if "%CurrentMaintainer%"=="Foff " (set /A Broken=%Broken%-1) else (set Broken=%BrokenOriginal%)
	if "%CurrentMaintainer%"=="FAIL " (set Broken=%BrokenOriginal%)
	if %Broken% LSS 1 (set Broken=%BrokenOriginal%)
	if %TakeOver% LSS 1 ( goto goActive )
	if %Alone% LSS 1 ( goto goActive )
	if %RandomRegister% == 1 (echo count again> P:\SCI_CHAT\maintainers.txt)
	if not exist P:\SCI_CHAT\maintainers.txt (echo count again>P:\SCI_CHAT\maintainers.txt)
	title Maintainer %MaintainerID% (%TakeOver%/%Broken%/%Alone%/%RegisterRounds%/%Unoriginal%/%failboost%) - maintainers aprox.: %maintainers%
	set /A RegisterRounds=%RegisterRounds%-1
	if %RegisterRounds% == 0 (echo %MaintainerID% >> P:\SCI_CHAT\maintainers.txt)
	if %RegisterRounds% == 0 (goto skipcounting)
	if %maintainers% == 1 (set RegisterRounds=1)
	if %failboost% GEQ 1 (set /A failboost=%failboost% - 1)
	:skipcounting
	timeout /nobreak %CheckDelay%
	set /A ObserveRounds=%maintainers%
	goto observe
:NoDoesNot

if not exist P:\SCI_CHAT\maintainer.txt ( echo maintainer file doesn't exist ) else (goto YesDoes)
	if not exist P:\SCI_CHAT\ ( mkdir P:\SCI_CHAT\ )
	echo FAIL > P:\SCI_CHAT\maintainer.txt
	timeout /nobreak %CheckDelay%
	goto start
:YesDoes


goto start
:observe
if %failboost% GEQ 1 (set /A ObserveRounds=%ObserveRounds% / 2)
if %ObserveRounds% LSS 1 (goto start)
set /A ObserveRounds=%ObserveRounds%-1
if "%CurrentMaintainer%"=="NEWMAINTAINER " (set TakeOver=%TakeOverOriginal%)
if "%CurrentMaintainer%"=="NEWMAINTAINER " (set Broken=%BrokenOriginal%)
if "%CurrentMaintainer%"=="NEWMAINTAINER " (set /A failboost=0)
if "%CurrentMaintainer%"=="FIX " (set Broken=%BrokenOriginal%)
if "%CurrentMaintainer%"=="FAIL " (set Broken=%BrokenOriginal%)
if "%CurrentMaintainer%"=="FAIL " (set /A failboost=3)
if "%CurrentMaintainer%"=="FAIL " (echo FIX > P:\SCI_CHAT\maintainer.txt)
title Maintainer %MaintainerID% Observing(%ObserveRounds%) (%TakeOver%/%Broken%/%Alone%/%RegisterRounds%/%Unoriginal%/%failboost%) - maintainers aprox.: %maintainers%
timeout /nobreak 10
if %ObserveRounds% LSS %OriginalRounds% ( if "%CurrentMaintainer%"=="%MaintainerID% " (set /A Unoriginal=%Unoriginal%-1) )
if %Unoriginal% == 0 ( set MaintainerID=D%RANDOM% )
if %Unoriginal% == 0 ( set Unoriginal=%UnoriginalOriginal% )
if exist P:\SCI_CHAT\maintainer.txt (for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x)
if exist P:\SCI_CHAT\verifyunique.txt (for /f "delims=" %%x in (P:\SCI_CHAT\verifyunique.txt) do set VerifiedMaintainer=%%x)
if exist P:\SCI_CHAT\maintainers.txt (for /f %%a in ('!countmaintainers!') do set maintainers=%%a)
if %maintainers% == 1 (set RegisterRounds=1)
if "%CurrentMaintainer%"=="%VerifiedMaintainer%" (set /A Broken=%BrokenOriginal%) else (set /A Broken=%Broken%-1)
if %Broken% == 0 (echo FAIL > P:\SCI_CHAT\maintainer.txt)
goto observe

:goActive
if exist P:\SCI_CHAT\maintainers.txt (for /f %%a in ('!countmaintainers!') do set maintainers=%%a)
set /A TakeOver=30
set /A RegisterRounds=%maintainers%*3
echo "New maintainer selected (%MaintainerID%), wait 30s for confirmation" >> P:\SCI_CHAT\lowtext.txt
:announce
for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
if "%CurrentMaintainer%"=="Foff " (echo "Maintainer (%MaintainerID%) backed off" >> P:\SCI_CHAT\lowtext.txt)
if "%CurrentMaintainer%"=="Foff " (goto restart)
title Maintainer %MaintainerID% ANNOUNCING SELECTION...%TakeOver%
echo NEWMAINTAINER > P:\SCI_CHAT\maintainer.txt
timeout /nobreak 1
if "%TakeOver%"=="25" (timeout /nobreak 1)
if "%TakeOver%"=="15" (timeout /nobreak 1)
if "%TakeOver%"=="5" (timeout /nobreak 1)
if "%CurrentMaintainer%"=="Foff " (echo "Maintainer (%MaintainerID%) backed off" >> P:\SCI_CHAT\lowtext.txt)
if "%CurrentMaintainer%"=="Foff " (goto restart)
set /A TakeOver=%TakeOver%-1
if "%TakeOver%"=="0" (set TakeOver=10) else ( goto announce )
echo "Maintainer %MaintainerID% is maintaining chat now" >> P:\SCI_CHAT\lowtext.txt
:maintain
timeout /nobreak 2
if not exist P:\SCI_CHAT\ ( mkdir P:\SCI_CHAT\ )
if not exist P:\SCI_CHAT\INBOX ( mkdir P:\SCI_CHAT\INBOX )
echo %MaintainerID% > P:\SCI_CHAT\maintainer.txt
if exist P:\SCI_CHAT\maintainers.txt (for /f %%a in ('!countmaintainers!') do set maintainers=%%a)
title Maintainer %MaintainerID% MAINTAINING %TakeOver% (Stability = %Broken%/10) maintainers aprox.: %maintainers% reregister: %RegisterRounds%
set /A TakeOver=%TakeOver%-1
if %TakeOver% == 9 (echo %MaintainerID% >> P:\SCI_CHAT\verifyunique.txt)
if %TakeOver% LSS 1 (set TakeOver=10)
if "%TakeOver%"=="10" (goto checkBroken)



pushd P:\SCI_CHAT\INBOX\

if not exist P:\SCI_CHAT\INBOX\* (goto maintain)
for /f  "usebackq delims=;" %%B in (`dir P:\SCI_CHAT\INBOX\ /b /A:-D *.txt`) do If %%~zB GTR %min.size% del "P:\SCI_CHAT\INBOX\%%B"
type "P:\SCI_CHAT\INBOX\*" >> P:\SCI_CHAT\lowtext.txt
del /Q "P:\SCI_CHAT\INBOX\*"

if exist P:\SCI_CHAT\lowtext.txt (for /f %%a in ('!countlowtext!') do set lowtext=%%a)
if %lowtext% GEQ 12 (type P:\SCI_CHAT\midtext.txt > P:\SCI_CHAT\hightext.txt)
if %lowtext% GEQ 12 (type P:\SCI_CHAT\lowtext.txt > P:\SCI_CHAT\midtext.txt)
if %lowtext% GEQ 12 (break>P:\SCI_CHAT\lowtext.txt)
set lowtext=0

for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
if "%CurrentMaintainer%"=="NEWMAINTAINER " (set TakeOver=0)

goto maintain

:checkBroken
if %Broken% LSS 10 (set /A Broken=%Broken% + 1)
if exist P:\SCI_CHAT\verifyunique.txt (for /f %%a in ('!verifyunique!') do set unique=%%a)
if %unique% == 1 (echo ok) else (set /A Broken=%Broken%-2)
break>P:\SCI_CHAT\verifyunique.txt
for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
if "%CurrentMaintainer%"=="NEWMAINTAINER " (goto deffendstart)
timeout /nobreak 2
for /f "delims=" %%x in (P:\SCI_CHAT\maintainer.txt) do set CurrentMaintainer=%%x
if "%CurrentMaintainer%"=="NEWMAINTAINER " (goto deffendstart)
if %Broken% LSS 3 (echo "!Maintainer %MaintainerID% unstable" >> P:\SCI_CHAT\lowtext.txt)
if %Broken% LSS 1 (echo "Maintainer %MaintainerID% failed" >> P:\SCI_CHAT\lowtext.txt)
if %Broken% LSS 1 (set MaintainerID=B%RANDOM%)
if %Broken% LSS 1 (break>P:\SCI_CHAT\verifyunique.txt)
if %Broken% LSS 1 (echo FAIL > P:\SCI_CHAT\maintainer.txt)
if %Broken% LSS 1 (goto restart)
if %RegisterRounds% LSS 1 (echo count again> P:\SCI_CHAT\maintainers.txt)
if %RegisterRounds% LSS 1 (set /A RegisterRounds=%maintainers%*3 )else (set /A RegisterRounds=%RegisterRounds%-1)
goto maintain

:deffendstart
set TakeOver=10
echo "Maintainer %MaintainerID% telling new maintainer to f off" >> P:\SCI_CHAT\lowtext.txt
:deffend
echo Foff > P:\SCI_CHAT\maintainer.txt
timeout /nobreak 1
set /A TakeOver=%TakeOver%-1
if "%TakeOver%"=="0" (goto checkBroken)
goto deffend