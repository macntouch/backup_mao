@echo off

rem description	: This script makes backups of your Alcatel-Lucent PBX
rem		  More info - http://dontforgetitplz.blogspot.com/2013/10/alcatel-licent-oxe-cpu.html
rem author	: Dmitry Myasnikov <saver_is_not@bk.ru>
rem version	: 1.0.0

rem i - имя станции, j - IP-адрес, k - имя, l - пароль, m - путь
FOR /F "eol=; skip=1 tokens=1-5* delims=|" %%i in (ats_config.txt) do (

  if not exist %%m\%DATE%\%%i\DAY mkdir %%m\%DATE%\%%i\DAY
  if exist %%i.dat del %%i.dat

  echo user %%k> %%i.dat
  echo %%l>> %%i.dat
  echo bin>> %%i.dat
  echo cd /usr4/BACKUP/DAY>> %%i.dat
  echo get mao-dat %%m\%DATE%\%%i\DAY\mao-dat>> %%i.dat
  echo get cho-dat %%m\%DATE%\%%i\DAY\cho-dat>> %%i.dat
  echo quit>> %%i.dat

  ftp -n -s:%%i.dat %%j

  del %%i.dat

   rar a -r %%m\%DATE%.rar %%m\%DATE%\
   del /S /Q %%m\%DATE%
   rmdir /S /Q %%m\%DATE%

)



