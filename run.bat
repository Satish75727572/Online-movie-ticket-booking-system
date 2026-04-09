@echo off
echo ==============================================
echo Starting BookMyShow Web Application
echo ==============================================

:: Set JAVA_HOME dynamically based on the system's JDK path
set JAVA_HOME=C:\Program Files\Java\jdk-24
echo [INFO] JAVA_HOME is set to: %JAVA_HOME%

:: Navigate to Tomcat bin directory and start the server
set TOMCAT_BIN=..\..\bin
cd %TOMCAT_BIN%

echo [INFO] Starting Apache Tomcat...
call startup.bat

echo ==============================================
echo [SUCCESS] Server is starting up!
echo Opening your web browser to the homepage...
echo ==============================================

:: Wait a couple of seconds for Tomcat to initialize, then launch the browser
timeout /t 3 /nobreak > NUL
start http://localhost:8080/Project/

cd ..\webapps\Project
