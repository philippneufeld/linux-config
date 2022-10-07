## Install config
execute init.sh

## DMenu launcher
rofi

## Natural touchpad scrolling
Maybe: install xf86-input-libinput driver
Add ´´´Option "NaturalScrolling" "true"´´´ to /etc/X11/xorg.conf.d/30-touchpad.conf

## Calendar
Install dependencies:
sudo pacman -S calcurse python-httplib2 python-oauth2client

Initialize config file (.config/calcurse/caldav/config):
see https://calcurse.org/files/calcurse-caldav.html

Initialize caldav (authenitification in browser)
calcurse-caldav --init=two-way


