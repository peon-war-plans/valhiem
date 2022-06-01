#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
rootpath="/home/steam/steamcmd/"
cd $rootpath
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
echo "##################### STARTING SERVER ######################"
# CUSTOM GAME SERVER COMMAND
echo $SERVERNAME >> /var/log/peon/debug.log
echo $WORLDNAME >> /var/log/peon/debug.log
echo $PASSWORD >> /var/log/peon/debug.log
cd data && ./valheim_server.x86_64 -name $SERVERNAME -port 2456 -world $WORLDNAME -password $PASSWORD -public 1