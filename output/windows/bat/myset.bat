@echo off

call myspace.bat
call mydev.bat
call myproj.bat

call :set_env MYSPACE "%MYSPACE%"
call :set_env MYDEV "%MYDEV%"
call :set_env PATH "%MYPROJ%\MyProfile\output\windows\bat;%MYPROJ%\MyProfile\output\windows\QuickStart;%MYDEV%\AStyle\bin"
pause > nul
goto :eof

:: set_env ���û�������
:: name  ����������
:: value ��������ֵ
:set_env
	set name=%~1
	set value=%~2
	:: ���������
	set /p=%name%=%value% < nul
	setx %name% "%value%"
goto :eof
