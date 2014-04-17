#!/bin/zsh

# Manage environment look
xsetroot -cursor_name left_ptr
xset b 100 0 0
#Best viewed with >>>Xmobar[94%]<<
#trayer --edge top --align right --SetDockType true --width 6 --transparent true --height 13 --SetPartialStrut true --tint 000000 & 
#feh --bg-scale /home/yiannis/pictures/GT1680x1050.jpg 

# Pre-spawn some apps:
urxvtd -q -f -o
eval `ssh-agent`
xcompmgr -c &

xrdb -merge ~/.Xresources

xrandr --output DVI-0 --primary --mode 1920x1080 --output DVI-1 --mode 1920x1080 --right-of DVI-0 --output DisplayPort-0 --mode 1680x1050 --right-of DVI-1

xset -dpms
setterm -blank 0 -powerdown 0
xset s off

pmount -w /dev/sdd1 Cavalry
pmount -w /dev/sda1 Windows

if [[ $1 == "i3" ]]; then
    exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3 -V -d all > ~/.i3/i3log-$(date +'%F-%k-%M-%S') 2>&1
elif [[ $1 == "razor" ]]; then
    exec ck-launch-session dbus-launch startrazor
elif [[ $1 == "awesome" ]]; then
    exec ck-launch-session dbus-launch awesome
elif [[ $1 == "qtile" ]]; then
    exec /usr/bin/qtile
elif [[ $1 == "xmonad" ]]; then
    exec xmonad
else
    echo "Choose a window manager"
fi
