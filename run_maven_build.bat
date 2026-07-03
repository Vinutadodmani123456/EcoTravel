@echo off
set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"
"maven_extracted\apache-maven-3.9.6\bin\mvn.cmd" -q -DskipTests clean package
