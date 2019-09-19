@echo off
set /p Username=Nazwa uzytkownika:
set Username=%RANDOM%%Username%
echo twoja nazwa to %Username%
echo Wiadomosci przekraczające 120 znakow nie zostaną przyjete
title SCIchat2 Sender - %Username%
:pismo
set /p Wiadomosc=%Username%:
set Wiadomosc=%Username%: %Wiadomosc%
echo %Wiadomosc%> P:\SCI_CHAT\INBOX\%Username%.txt
goto pismo