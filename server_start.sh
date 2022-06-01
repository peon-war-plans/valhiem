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
# Create a server.config file which contains relevant connection info for gamers (in the config directory)
conf_file="/home/steam/.config/unity3d/IronGate/Valheim/server.config"
public_ip=$(/usr/bin/dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')
printf "IP [$public_ip] Name [$SERVERNAME] World [$WORLDNAME] Password [$PASSWORD]" > $conf_file
# CUSTOM GAME SERVER COMMAND
cd data && ./valheim_server.x86_64 -name $SERVERNAME -port 2456 -world $WORLDNAME -password $PASSWORD -public 1