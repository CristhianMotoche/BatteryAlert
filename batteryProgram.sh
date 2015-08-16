#!/bin/bash

#lectura archivos
fileCapacity="/sys/class/power_supply/BAT0/capacity"
fileStatus="/sys/class/power_supply/BAT0/status"
actualDir=`pwd`"/img/icon_battery-"
imgHigh=$actualDir"high.svg"
imgLow=$actualDir"low.svg"

if [ -e $fileCapacity ] && [ -e $fileStatus ]; then
    
    #tomar valores
    capacity=$(cat "$fileCapacity")
    status=$(cat "$fileStatus")

    #alerta
    if [ $capacity -gt 85 ] && [ $status == "Charging" ] ; then
	DISPLAY=:0.0 /usr/bin/notify-send -i `echo $imgHigh` "Desconectar computadora:" \
		    "Actualmente $capacity\%"
    elif [ $capacity -lt 15 ] && [ $status == "Discharging" ] ; then
	DISPLAY=:0.0 /usr/bin/notify-send -i `echo $imgLow` "Conectar computador: " \
	       "Actualmente $capacity\%"	
    fi
else
    DISPLAY=:0.0 /usr/bin/notify-send "No se encuentra los archivos"
fi
