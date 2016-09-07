:: 设置环境变量 %MYGOLANG%

@echo off

call mydev.bat
call myproj.bat
call myjdk.bat

set GOLANG=%MYDEV%\GoLang
set GOROOT=%GOLANG%\go
set GOPATH=%MYPROJ%\go
set GOBIN=%GOROOT%\bin
set PATH=%GOBIN%;%PATH%
