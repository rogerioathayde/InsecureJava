echo OFF
if exist "%cd%\jre1.5.0_05-forTomcat5" goto foundJRE
echo jre1.5.0_05-forTomcat5 subdir not found; Please start this script from this script's directory. Unable to continue.
pause
goto done
:foundJRE

if exist "%cd%\tomcat-5.5.12" goto foundTomcat
echo tomcat-5.5.12 subdirectory not found. Unable to continue.
pause
goto done
:foundTomcat

set JAVA_HOME=%cd%\jre1.5.0_05-forTomcat5
cd tomcat-5.5.12
CALL bin\startup.bat

SET waitAttempts=
:waitForServer

SET waitAttempts=%waitAttempts%.
ECHO Waiting for Tomcat WebServer to start..%waitAttempts%
PING -n 2 127.0.0.1 >NUL

NETSTAT -an | find /i "listening" |find /i "0.0.0.0:8080" >NUL
IF NOT ERRORLEVEL 1 GOTO serverReady
ECHO %waitAttempts% | find /i "....." >NUL
IF ERRORLEVEL 1 GOTO waitForServer


:serverReady
start http://localhost:8080/

:done