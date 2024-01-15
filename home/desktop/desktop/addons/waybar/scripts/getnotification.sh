#!/usr/bin/env bash

GREEN='\e[1;32m'
NC='\033[0m' # No Color
GREY='\e[0;90m'

# Get latest notification from dbus-monitor

echo "timestamp: 1 
icon: 
appname: waybar
summary: Hello!
body: " >~/.config/waybar/store/lastnotif

dbus-monitor "interface='org.freedesktop.Notifications'" | grep --line-buffered "member=Notify\|string" | while read line; do
    printf "${GREY}debug: $line${NC}\n"
    if [[ $line == *"member=Notify"* ]]; then
        # Remove everything before the timestamp and after the . sign
        timestamp=$(echo $line | sed 's/.*time=\([0-9]*\).*/\1/')
        printf "\n${GREEN}timestamp:${NC} $timestamp\n"
        sed -i "1s|.*|timestamp: $timestamp|" ~/.config/waybar/store/lastnotif
        linenumber=0
    else
        if [[ $line == *"string"* ]]; then
            linenumber=$((linenumber + 1))

            if [ $linenumber -eq 1 ]; then
                appname=$(echo "$line" | sed 's/string //g; s/\"//g')
                printf "${GREEN}appname:${NC} $appname\n"
                sed -i "2s|.*|appname: $appname|" ~/.config/waybar/store/lastnotif
            fi

            if [ $linenumber -eq 2 ]; then
                icon=$(echo $line | sed 's/string //g; s/\"//g')
                printf "${GREEN}icon:${NC} $icon\n"
                sed -i "3s|.*|icon: $icon|" ~/.config/waybar/store/lastnotif
            fi

            if [ $linenumber -eq 3 ]; then
                summary=$(echo $line | sed 's/string //g; s/\"//g')
                printf "${GREEN}summary:${NC} $summary\n"
                sed -i "4s|.*|summary: $summary|" ~/.config/waybar/store/lastnotif
            fi

            if [ $linenumber -eq 4 ]; then
                body=$(echo $line | sed 's/string //g; s/\"//g')
                printf "${GREEN}body:${NC} $body\n"
                sed -i "5s|.*|body: $body|" ~/.config/waybar/store/lastnotif
            fi
        fi
    fi
done
