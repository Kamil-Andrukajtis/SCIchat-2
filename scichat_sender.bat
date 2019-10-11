@echo off
mode con: cols=120 lines=4
title SCIchat2 Sender
set Username=%USERNAME%
echo twoja nazwa to %Username%
echo Wiadomosci przekraczajace 120 znakow nie zostana przyjete
title SCIchat2 Sender - %Username%
:pismo
set /p Wiadomosc=%Username%:
set Wiadomosc=%Username%:%Wiadomosc%
echo %Wiadomosc%> P:\SCI_CHAT\INBOX\%Username%.png
goto pismo