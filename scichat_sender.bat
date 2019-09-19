@echo off
set /p Username=Nazwa uzytkownika:
set Username=%RANDOM%%Username%
echo twoja nazwa to %Username%
echo Wiadomosci przekraczajace 100 znakow nie zostano przyjete
:pismo
set /p Wiadomosc=%Username%:
set Wiadomosc=%Username%: %Wiadomosc%
echo %Wiadomosc%> P:\SCI_CHAT\INBOX\%Username%.txt
goto pismo