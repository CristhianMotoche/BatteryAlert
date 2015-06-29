#!/bin/bash

#lectura archivos
fileCapacity="/sys/class/power_supply/BAT0/capacity"
fileStatus="/sys/class/power_supply/BAT0/status"

if [ -e $fileCapacity ] && [ -e $fileStatus ]; then
    
    #tomar valores
    capacity=$(cat "$fileCapacity")
    status=$(cat "$fileStatus")

    #alerta
    if [ $capacity -gt 85 ] && [ $status == "Charging" ] ; then
	DISPLAY=:0.0 /usr/bin/notify-send "Desconectar computadora:" \
		    "Actualmente $capacity\%"
    elif [ $capacity -lt 15 ] && [ $status == "Discharging" ] ; then
	DISPLAY=:0.0 /usr/bin/notify-send "Conectar computador: " \
	       "Actualmente $capacity\%"	
    fi
else
    DISPLAY=:0.0 /usr/bin/notify-send "No se encuentra los archivos"
fi
