#!/bin/bash

# delete old image
rm "$1"_*.jpg
img_pth="$1_$RANDOM".jpg

# download updated image
curl -s https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/1808x1808.jpg > "$img_pth"

GIO_EXTRA_MODULES="/usr/lib/x86_64-linux-gnu/gio/modules/"
export GIO_EXTRA_MODULES

PID=$(pgrep gnome-session | head -n 1)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

# set standard and dark theme background
gsettings set org.gnome.desktop.background picture-options "scaled"
gsettings set org.gnome.desktop.background picture-uri-dark file://"$img_pth"
gsettings set org.gnome.desktop.background picture-uri file://"$img_pth"

