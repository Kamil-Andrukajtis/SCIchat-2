@echo off
title SCIchat2 Reader
:start
cls
if exist P:\SCI_CHAT\hightext.txt (type P:\SCI_CHAT\hightext.txt)
if exist P:\SCI_CHAT\midtext.txt (type P:\SCI_CHAT\midtext.txt)
if exist P:\SCI_CHAT\lowtext.txt (type P:\SCI_CHAT\lowtext.txt)
timeout /nobreak 3
goto start