#!/bin/bash

fileCapacity="/sys/class/power_supply/BAT0/capacity"
fileStatus="/sys/class/power_supply/BAT0/status"

if [ -e $file ]; then
    capacity=$(cat "$fileCapacity")
    status=$(cat "$fileStatus")
    if [ $capacity -gt 85 ] && [ $status == "Charging" ] ; then
	DISPLAY=:0.0 /usr/bin/notify-send "Desconectar computadora:" \
		    "Actualmente $capacity\%"
    else
	DISPLAY=:0.0 /usr/bin/notify-send "Si funca"
    fi
    
fi
