@echo off

:main
echo.
echo Got command: "%1"

if "%1" == "" goto end

for /f "delims=" %%A in ('python -c "import getpass; print(getpass.getpass('Password: '));"') do @set pass=%%A
set login=-u ftp99691459-1 -p %pass% access812755966.webspace-data.io

if "%1" == "all" (
	set source=.\publish
	set dest=~
	goto sendfolder
)

if "%1" == "wwwroot" (
	set source=.\wwwroot
	set dest=publish\
	goto sendfolder
)

if "%1" == "css" (
	set source=.\publish\*.css
	set dest=publish\
	goto sendfiles
)

if "%1" == "js" (
	set source=.\publish\*.js
	set dest=publish\
	goto sendfiles
)

if "%1" == "html" (
	set source=.\publish\*.html
	set dest=publish\
	goto sendfiles
)

if "%1" == "clean" (
	set dest=publish\*
	goto clean
)


:: -m will create dir if not exist
:: -r recursive

:sendfolder
NcFTP\ncftpput -R -m %login% %dest% %source%
goto exit

:sendfiles
NcFTP\ncftpput -m %login% %dest% %source%
goto exit

:: not working

:clean
NcFTP\ncftpput %login% "" "" -W "rm -rf %dest%"
goto exit

:end
echo 1. all		to send full publish folder
echo 2. wwwroot	to send only wwwroot
echo 3. css		to send only compiled and cssfiles in publish folder
echo 4. js		to send only compiled and json files in publish folder
echo 5. html		to send only html files
echo 6. clean	deletes everything in the destination
goto exit

:exit
echo.
