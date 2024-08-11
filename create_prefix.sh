#!/bin/bash

unset DISPLAY
export WINEDEBUG=-all
export WINEPREFIX=$HOME/.wine
export WINEARCH=win32

INSTALLER=$PWD/awincupl.exe
PATCH=$PWD/user.reg.diff

rm -rf $WINEPREFIX
wine hostname
winetricks mfc40
cp awincupl.iss $WINEPREFIX/drive_c/
wine awincupl.exe /s /f1"c:\awincupl.iss"
# Wine keeps writing after returning?
sleep 2
cd $WINEPREFIX
cat $PATCH | patch -p0
cd -
