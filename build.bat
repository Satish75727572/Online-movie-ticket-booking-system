@echo off
echo Compiling all Java files...
javac -cp "WEB-INF\lib\*" -d WEB-INF\classes src\*.java
if %errorlevel%==0 (
    echo Compilation successful! Class files are in WEB-INF\classes\
) else (
    echo Compilation failed!
)
pause
