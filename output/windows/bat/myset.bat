@echo off

call myspace.bat
call mydev.bat
call myproj.bat

call :set_env MYSPACE "%MYSPACE%"
call :set_env MYDEV "%MYDEV%"
call :set_env PATH "%MYPROJ%\functions;%MYPROJ%\functions\Quick Start;%MYDEV%\AStyle\bin"
pause > nul
goto :eof

:: set_env 设置环境变量
:: name  环境变量名
:: value 环境变量值
:set_env
	set name=%~1
	set value=%~2
	:: 输出不换行
	set /p=%name%=%value% < nul
	setx %name% "%value%"
goto :eof
