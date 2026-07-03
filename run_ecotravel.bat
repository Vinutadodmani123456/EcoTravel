@echo off

:: Load environment variables from .env if it exists
if exist "%~dp0\.env" (
  for /f "usebackq tokens=*" %%A in ("%~dp0\.env") do set "%%A"
)

set "PROJECT_DIR=%~dp0"
set "CATALINA_HOME=%PROJECT_DIR%tomcat_extracted\apache-tomcat-11.0.4"
set "CATALINA_BASE=%CATALINA_HOME%"
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "JRE_HOME=C:\Program Files\Java\jdk-25.0.2"

cd /d "%CATALINA_HOME%\bin"
call catalina.bat run
