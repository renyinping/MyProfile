@echo off

call myspace.bat
call myprofile.bat

call :ln_profile "Documents\Tencent Files"
call :ln_profile "Documents\WeChat Files"
call :ln_profile "Documents\Virtual Machines"
goto :eof

:: ln_profile �����û�����
:: %1 ����Ŀ¼��; ���� "Documents\Tencent Files"
:ln_profile
	rmdir     "%USERPROFILE%\%~1"
	mklink /J "%USERPROFILE%\%~1" "%MYPROFILE%\%~1"
	echo.
goto :eof

