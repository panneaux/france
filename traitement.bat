@setlocal enableextensions enabledelayedexpansion

::Turn of displaying the code on the screen
@echo off

REM %1 premier argument : chemin du dossier contenant les images originales
REM on stocke le chemin du répertoire courant dans la variable github et on se positionne dans le répertoire contenant les images orginales
set github=%~dp0
cd %1

REM les 3 autres arguments suivants vont servir à construire :
REM     - le chemin du répertoire qui stockera les images produites chemin/du/dossier/github/images/%2/%3/%4
REM     - le préfixe utilisé pour les noms d'images %4_%3

set folder="%github%/images/%2/%3/%4"
set prefix="%3_%4"
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

endlocal