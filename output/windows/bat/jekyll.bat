:: Jekyll
@echo off

call mydev.bat
call myproj.bat

set RUBY_INSTALL_DIR=%MYDEV%\ruby
set RUBY_BIN=%RUBY_INSTALL_DIR%\bin;
set RUBY_BIN=%RUBY_BIN%;%RUBY_INSTALL_DIR%\devkit\bin
set RUBY_BIN=%RUBY_BIN%;%RUBY_INSTALL_DIR%\devkit\mingw\bin
set PATH=%RUBY_BIN%;%PATH%

call :jekyll_start "%MYPROJ%\renyinping.github.com"
goto :eof

:: jekyll
:: jekyll_root Jekyll ��Ŀ¼
:jekyll_start
	set jekyll_root=%~1
	if exist "%jekyll_root%" (
		cd "%jekyll_root%"
		jekyll server
	) else (
		echo �Ҳ��� Jekyll ��Ŀ¼
		pause
	)
goto :eof
