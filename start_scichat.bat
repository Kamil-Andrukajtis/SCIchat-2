if exist "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\scichat_maintainer.bat" (start uninstall_scichat_maintainer.bat)
if not exist "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\scichat_maintainer.bat" ( copy "scichat_maintainer.bat" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" )
start /I scichat_maintainer.bat
timeout /nobreak 1
start /I scichat_reader.bat
timeout /nobreak 1
start /I scichat_sender.bat