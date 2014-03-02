#!/bin/zsh
xrdb -merge ~/.Xresources
#xcompmgr &
pmount -w /dev/sdc1 MyBook
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
else
    echo "Choose a window manager"
fi
