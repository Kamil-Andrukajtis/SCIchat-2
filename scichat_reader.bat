@echo off
title SCIchat2 Reader
mode con: cols=120 lines=40
:start
cls
if exist P:\SCI_CHAT\hightext.png (type P:\SCI_CHAT\hightext.png)
if exist P:\SCI_CHAT\midtext.png (type P:\SCI_CHAT\midtext.png)
if exist P:\SCI_CHAT\lowtext.png (type P:\SCI_CHAT\lowtext.png)
timeout /nobreak 3
goto start