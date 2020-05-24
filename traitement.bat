@setlocal enableextensions enabledelayedexpansion

::Turn of displaying the code on the screen
@echo off

REM %1 premier argument : chemin du dossier contenant les images originales
REM on stocke le chemin du répertoire courant dans la variable github et on se positionne dans le répertoire contenant les images orginales
set github=%~dp0
cd %1

REM les 3 autres arguments suivants vont servir à construire :
REM     - le chemin du répertoire qui stockera les images produites chemin/du/dossier/github/images/%2/%3
REM     - le préfixe utilisé pour les noms d'images %2_%3

set folder="%github%/images/%2/%3"
set prefix="%2_%3"
echo !prefix!
echo !folder!
if exist %folder% (
    echo "folder !folder! already exists - going to remove it"
    RMDIR /S %folder%
)
MKDIR %folder%
echo "an empty folder !folder! has been created"

REM lecture des images originales
REM création des images 800x600, des miniatures et enregistrement dans le dossier de destination
set /A nb=0

FOR %%G IN (*.jpg) DO (
  :: if you want only the file name without the extension, you can use %%~nG
  set /A nb+=1
  echo !nb!
  convert "%%G" -resize 800x600 -rotate "90" "%folder%/%prefix%_!nb!.jpg"
  convert "%%G" -resize 200x150 -rotate "90" "%folder%/%prefix%_!nb!-thumb.jpg"
)

FOR %%G IN (landscape/*.jpg) DO (
  set /A nb+=1
  echo !nb!
  convert "landscape/%%G" -resize 800x600 "%folder%/%prefix%_!nb!.jpg"
  convert "landscape/%%G" -resize 100x75 "%folder%/%prefix%_!nb!-thumb.jpg"
)

cd %github%/_posts

for /f "tokens=1,2,3 delims=/ " %%a in ('date /t') do set now=%%c-%%b-%%a

set postname="%now%-%prefix%.md"

if exist %postname% (
    rm %postname%
)


(echo ---
echo layout: page
echo header: no
echo subheadline:  %now%
echo title: %3
echo breadcrumb: true
echo permalink: /%2/%3
echo categories:
echo     - dep
echo tags:
echo     - dep
echo image:
echo    base: %2/%3/%2_%3
echo    start: 1
echo    max: %nb%
echo ---
echo {%% include gallery %%}
echo {: .t60 }
echo {%% include list-posts tag='misc' %%})>>%postname%

endlocal