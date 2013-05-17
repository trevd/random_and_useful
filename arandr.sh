#!/bin/sh 
#
# Script to setup ati- HD57xx series for use with 3 monitors
#
xrandr --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-1 \
--mode 1920x1080 --pos 3840x0 --rotate normal --output DVI-0 --off --output HDMI-0 \
--mode 1920x1080 --pos 1920x0 --rotate normal
