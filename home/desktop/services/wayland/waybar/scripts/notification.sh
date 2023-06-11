#!/usr/bin/env bash

timeout=3

# if dbus-monitor is not running, start it
if ! pgrep -x "dbus-monitor" >/dev/null; then
    $HOME/.config/waybar/scripts/getnotification.sh &
fi

while true; do
    dunststatus=$(dunstctl is-paused)
    realtime=$(date +%s)
    lines=$(cat ~/.config/waybar/store/lastnotif)
    while read line; do
        if [[ $line == *"timestamp"* ]]; then
            timestamp=$(echo $line | sed 's/timestamp: //g')
        fi
        if [[ $line == *"appname"* ]]; then
            appname=$(echo $line | sed 's/appname: //g')
        fi
        if [[ $line == *"summary"* ]]; then
            summary=$(echo $line | sed 's/summary: //g')
        fi
        if [[ $line == *"body"* ]]; then
            body=$(echo $line | sed 's/body: //g')
        fi
        if [[ $line == *"icon"* ]]; then
            icon=$(echo $line | sed 's/icon: //g')
        fi
    done <<<"$lines"

    # Calculate the difference between the current time and the timestamp
    timediff=$(($realtime - $timestamp))

    if [ $timediff -gt $(($timeout - 1)) ]; then
        if [ $dunststatus = "false" ]; then
            echo '{"text": "", "alt": "notification", "class": "collapsed"}' | jq --unbuffered --compact-output
        else
            echo '{"text": "", "alt": "notification", "class": "collapsed_muted"}' | jq --unbuffered --compact-output
        fi
        sleep 0.3
    else
        if [ $dunststatus = "false" ]; then
            if [ "$summary" = "swww" ] && [ "$body" = 1 ]; then
                timeout=2
                echo '{"text": "", "alt": "notification", "class": "wallpaper"}' | jq --unbuffered --compact-output
                sleep 0.3
            else
                timeout=3
                echo '{"text": "", "alt": "notification", "class": "waiting_start"}' | jq --unbuffered --compact-output
                sleep 0.3
                echo '{"text": "'$summary': '$body'", "alt": "notification", "class": "expanded"}' | jq --unbuffered --compact-output
                sleep $timeout
                echo '{"text": "", "alt": "notification", "class": "waiting_done"}' | jq --unbuffered --compact-output
                sleep 0.4
            fi
        fi
    fi
done
