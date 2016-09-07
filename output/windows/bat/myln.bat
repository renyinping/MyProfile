@echo off

call myspace.bat
call myprofile.bat

call :ln_profile "Documents\Tencent Files"
call :ln_profile "Documents\WeChat Files"
call :ln_profile "Documents\Virtual Machines"
goto :eof

:: ln_profile 联接用户数据
:: %1 联接目录名; 比如 "Documents\Tencent Files"
:ln_profile
	rmdir     "%USERPROFILE%\%~1"
	mklink /J "%USERPROFILE%\%~1" "%MYPROFILE%\%~1"
	echo.
goto :eof

