#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo "Type 'sudo !!' below and press ENTER. Trust me, it makes the script go brrr."
    exit 1
else
    echo "Congratulation, you did the thing. Script can now go brrr."
fi

#Get the user who ran this command 'cos it's possible with this simple trick - don't ask me why
useris=$(who | head -n1 | awk '{print $1;}')
if [ "$useris" == "root" ]; then
    echo "Wait what the heck, that isn't how you run the script. You run it with sudo dammit. (how did you even do it this wrong?)"
    exit 1
fi

apt update
clear
echo "Dependency installation go brrr..."
apt install -y git python3-svgwrite python3-fonttools inkscape python3-numpy
apt install -y libxfce4ui-nocsd-2-0 || apt install -y libgtk3-nocsd0 gtk3-nocsd

clear
echo "Grabbing theme go brrr..."
cd /tmp
chicagodir=/
while [ -d "$chicagodir" ]; do
    chicagodir="/tmp/ChicagoStuff$RANDOM"
done

mkdir "$chicagodir"
cd "$chicagodir"
git clone https://github.com/grassmunk/Chicago95
chown -hR $useris:$useris "$chicagodir"
cd Chicago95

clear
echo "Patching theme go brrr..."
sed -i 's%@import url("gtk-titlebars.css");%/*@import url("gtk-titlebars.css");*/%g' Theme/Chicago95/gtk-3.0/gtk.css
sed -i 's%/*@import url("gtk-titlebars_no-csd.css");*/%@import url("gtk-titlebars_no-csd.css");%g' Theme/Chicago95/gtk-3.0/gtk.css
sed -i 's%@import url("gtk-headerbars.css");%/*@import url("gtk-headerbars.css");*/%g' Theme/Chicago95/gtk-3.0/gtk.css
sed -i 's%/*@import url("gtk-headerbars_no-csd.css");*/%@import url("gtk-headerbars_no-csd.css");%g' Theme/Chicago95/gtk-3.0/gtk.css
clear

rm -rf /home/$useris/.themes/Chicago95
while [ ! -d /home/$useris/.themes/Chicago95 ]; do
    sudo --user=$useris python3 ./installer.py &
    sleep 10
    read -p "

Install the theme. Yes.
Press ENTER here when it's done installing and you see that random instruction manual on screen. Don't close the instructions manual, though.
"
    if [ ! -d /home/$useris/.themes/Chicago95 ]; then
        clear
        echo "You cheated not only the script, but yourself.

You didn't grow.
You didn't Chicagofy.
You tried to troll the script and gained nothing.

You wasted your time.
Nothing was done and nothing was gained.

It's sad that you even bothered trying this.
Now just install the theme already."
    fi
done

clear
echo "Installing stuff system-wide go brrr..."
cp -Rfv ./Theme/Chicago95 /usr/share/themes/
cp -Rfv ./Icons/Chicago95 /usr/share/icons/

clear
echo "User configs go brrr..."
sudo --user=$useris xfconf-query -c xsettings -p /Gtk/DialogsUseHeader -s false

clear
echo "Installing a better browser that doesn't look like s***..."
apt-get install epiphany-browser -y
apt-get purge firefox* -y

echo "That's it right now. There's more to come."
exit 0