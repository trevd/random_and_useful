#!/bin/sh

~/arandr.sh 
G_FILE=/run/shm/geany.$USER
geany --socket-file $G_FILE $1 &
chromium-browser &
lxterminal &
exit
