#!/bin/bash

stty intr ''
set +m

if [ "$1" == "--userland" ]; then
    useris="$(whoami)"
    
    #Cleanup prior installs
    rm -rf /home/$useris/.themes/Chicago95 /home/$useris/.icons/Chicago95 /home/$useris/.Chicago95PlusFiles /home/$useris/.Chicago95Plus /home/$useris/.chicago95plus "/home/$useris/.icons/Chicago95 Animated Hourglass Cursors" "/home/$useris/.icons/Chicago95_Cursor_Black" "/home/$useris/.icons/Chicago95_Cursor_White" "/home/$useris/.icons/Chicago95_Emerald" "/home/$useris/.icons/Chicago95 Standard Cursors" "/home/$useris/.icons/Chicago95 Standard Cursors Black"
    rm -f /home/$useris/.local/share/xfce4/terminal/colorschemes/Chicago95.theme /home/$useris/Downloads/Chicago95.theme /home/$useris/.local/share/applications/chicago95plus.desktop /home/$useris/.chicago95plus /home/$useris/.config/gtk-3.0/gtk.css ~/.config/autostart/chicago95-startup.desktop
    if grep -q "Windows 95" /home/$useris/.bashrc; then
        rm -f /home/$useris/.bashrc
        cp -f /etc/skel/.bashrc /home/$useris/.bashrc
    fi
    
    if [ ! -d "$2" ] || [ -z "$2" ]; then
        echo "No. There is no folder here."
        exit 1
    fi
    
    cd "$2/Chicago95"
    
    clear
    
    rm -f /home/$useris/.local/share/xfce4/terminal/colorschemes/Chicago95.theme
    while [ ! -f /home/$useris/.local/share/xfce4/terminal/colorschemes/Chicago95.theme ]; do
        python3 ./installer.py
        if [ ! -f /home/$useris/.local/share/xfce4/terminal/colorschemes/Chicago95.theme ]; then
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
    
    if [ -f /usr/bin/firefox ] && [ -f "$2/chicago95_ie4_theme_yes.xpi" ]; then
        clear
        echo "Opening Firefox to install theme..."
        firefox "file://$2/chicago95_ie4_theme_yes.xpi" >/dev/null 2>&1 &
    fi
    if [ -f /usr/bin/palemoon ]; then
        clear
        echo "Opening Pale Moon to install theme..."
        palemoon "https://addons.palemoon.org/addon/moonscape/" >/dev/null 2>&1 &
    fi

    clear
    echo "User configs go brrr..."
    xfconf-query -c xsettings -p /Gtk/DialogsUseHeader -s false
    xfconf-query -c xsettings -p /Net/SoundThemeName -s Chicago95
    
    clear
    echo "Linking backgrounds into Pictures..."
    ln -sf /usr/share/Chicago95Backgrounds ~/Pictures/Chicago95
    mkdir ~/.Chicago95PlusFiles
    
    clear
    echo "Copying default theme .theme file into Home..."
    cp -f ./Extras/Chicago95.theme ~/Downloads/
    
    clear
    echo "Adding Chicago95 sound to startup..."
    mkdir ~/.config; mkdir ~/.config/autostart
    cp -f ./sounds/chicago95-startup.desktop ~/.config/autostart/chicago95-startup.desktop
    chmod +x ~/.config/autostart/chicago95-startup.desktop
    
    clear
    echo "Installing Chicago95 Plus..."
    sed -i 's%"/Pictures/"%"/.Chicago95PlusFiles/"%g' ./Plus/pluslib.py
    rm -rf ~/.Chicago95Plus ~/.chicago95plus
    cp -Rf ./Plus ~/.Chicago95Plus
    echo '#!/bin/bash
zenity --info --title="Chicago95 Plus" --text="Remember: When you Apply or OK, leave the computer alone until it is done.
The more you use the computer, the slower the process is." --no-wrap &
sleep 3
python3 '"$HOME"'/.Chicago95Plus/PlusGUI.py' > ~/.chicago95plus
    mkdir ~/.local; mkdir ~/.local/share; mkdir ~/.local/share/applications
    chmod +x ~/.chicago95plus
    echo "[Desktop Entry]
Version=1.0
Name=Chicago95 Plus!
GenericName=Plus! Theme Manager
Comment=Change the look of your Desktop
Exec=$HOME/.chicago95plus
Terminal=true
X-MultipleArgs=false
Type=Application
Icon=preferences-desktop-theme
Categories=Settings;" > ~/.local/share/applications/chicago95plus.desktop
    chmod +x ~/.local/share/applications/chicago95plus.desktop
    
    clear
    echo "Configuring theme some more..."
    mkdir ~/.config; mkdir ~/.config/gtk-3.0
    gtkver=$(dpkg -s libgtk-3-0 | grep '^Version:')
    gtkver=$(echo "${gtkver:11:12}")
    gtkver=$(echo "${gtkver:0:2}")
    if [ "$gtkver" -lt 21 ]; then
		false
    elif [ "$gtkver" -ge 22 ] && [ "$gtkver" -lt 24 ]; then
        cp -f ./Extras/override/gtk-3.22/gtk.css ~/.config/gtk-3.0/gtk.css
    elif [ "$gtkver" -ge 24 ]; then
        cp -f ./Extras/override/gtk-3.24/gtk.css ~/.config/gtk-3.0/gtk.css
    fi
    
    cp -f ./Extras/post_install.txt "$HOME/Desktop/Chicago95 Post-Install"
    
    killall mousepad
    
    clear
    read -p "Please install the themes for the browsers that have been opened by this script. Once done, press ENTER in this Terminal."
    
    clear
    echo "Welcome to Chicago 95. The system will now restart."
    sleep 2
    systemctl -i reboot || reboot
    
    exit 0
    
fi

chicagodir=/
while [ -d "$chicagodir" ]; do
    chicagodir="/tmp/ChicagoStuff$RANDOM"
done
mkdir "$chicagodir"

if [ "$1" == "--rootland" ]; then
echo "Congratulation, script will now go brrr."


#Get the user who ran this command 'cos it's possible with this simple trick - don't ask me why
useris=$(who | head -n1 | awk '{print $1;}')
if [ "$useris" == "root" ]; then
    echo "Wait what on earth, that isn't how you run the script. You run it with sudo. (how did you even do it this wrong?)"
    exit 1
fi
if [ ! -d "$2" ] || [ -z "$2" ]; then
    echo "No. There is no folder here."
    exit 1
fi

#Cleanup prior installs
rm -rf /usr/share/themes/Chicago95 /usr/share/icons/Chicago95 /usr/share/plymouth/themes/Chicago95 /usr/share/Chicago95Backgrounds "/usr/share/icons/Chicago95 Animated Hourglass Cursors" "/usr/share/icons/Chicago95_Cursor_Black" "/usr/share/icons/Chicago95_Cursor_White" "/usr/share/icons/Chicago95_Emerald" "/usr/share/icons/Chicago95 Standard Cursors" "/usr/share/icons/Chicago95 Standard Cursors Black" /usr/share/sounds/Chicago95

apt update
clear
echo "Dependency installation go brrr..."
apt install -y git python3-svgwrite python3-fonttools inkscape python3-numpy x11-apps gnome-session-canberra sox libcanberra-gtk3-module libcanberra-gtk-module python3 curl coreutils
apt install -y libxfce4ui-nocsd-2-0 || apt install -y libgtk3-nocsd0 gtk3-nocsd

clear
echo "Grabbing theme go brrr..."
cd /tmp

cd "$2"
git clone https://github.com/grassmunk/Chicago95
chown -hR $useris:$useris "$2"
cd Chicago95

clear
echo "Patching theme go brrr..."
sed -i 's%@import url("gtk-titlebars.css");%/*@import url("gtk-titlebars.css");*/%g' Theme/Chicago95/gtk-3.0/gtk.css
sed -i 's%.*@import url("gtk-titlebars_no-csd.css");.*%@import url("gtk-titlebars_no-csd.css");%g' Theme/Chicago95/gtk-3.0/gtk.css
sed -i 's%@import url("gtk-headerbars.css");%/*@import url("gtk-headerbars.css");*/%g' Theme/Chicago95/gtk-3.0/gtk.css
sed -i 's%.*@import url("gtk-headerbars_no-csd.css");.*%@import url("gtk-headerbars_no-csd.css");%g' Theme/Chicago95/gtk-3.0/gtk.css
clear

clear
echo "Installing stuff system-wide go brrr..."
cp -Rfv ./Theme/Chicago95 /usr/share/themes/
cp -Rfv ./Icons/Chicago95 /usr/share/icons/

clear
read -p "Alright, I have a question for you. Mozilla Firefox... doesn't look that great in this theme... since it's, y'know, Mozilla Firefox with the 'Proton' design. (that and the GTK theme just isn't designed for Firefox)

I would add functionality to this script to give Firefox the Redmond-Firefox UserChrome Style ( https://github.com/matthewmx86/Redmond-Firefox ), but... that's currently broken.

So, instead of that, would you like the script to:
1: Replace Firefox with Pale Moon except it now has cool Netscape styling?
2: Replace Firefox with a browser that... conveniently looks good with this theme?
N: Just give you a minor Internet Explorer 4 skin on your Mozilla Firefox because you don't care or whatever?

Pick one [1/2/N] " firefoxquestion
case "$firefoxquestion" in
    [1]) 
        palemonans="5"
        while [ "$palemonans" != "1" ] && [ "$palemonans" != "2" ] && [ "$palemonans" != "3" ] && [ "$palemonans" != "4" ]; do
            clear
            read -p "Installing a browser that doesn't look like crud with this theme on...
But first... choose an Ubuntu version:

1: Ubuntu 20.10 and newer
2: Ubuntu 20.04
3: Ubuntu 18.04 - 19.10
4: Ubuntu 16.04 - 17.10

Pick one [1-4] " palemonans
        done
        if [ "$palemonans" == "1" ]; then
            relforpalemonrepo="20.10"
        elif [ "$palemonans" == "2" ]; then
            relforpalemonrepo="20.04"
        elif [ "$palemonans" == "3" ]; then
            relforpalemonrepo="18.04"
        elif [ "$palemonans" == "4" ]; then
            relforpalemonrepo="16.04"
        fi
        echo "deb http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_$relforpalemonrepo/ /" | sudo tee /etc/apt/sources.list.d/home:stevenpusser.list
        curl -fsSL https://download.opensuse.org/repositories/home:stevenpusser/xUbuntu_$relforpalemonrepo/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_stevenpusser.gpg > /dev/null
        apt update
        apt install palemoon -y
        apt purge firefox* -y
        ;;
    [2]) 
        echo "Installing a browser that doesn't look like crud with this theme on..."
        apt install epiphany-browser -y
        apt purge firefox* -y
        ;;
    *)
        echo "Fine. You'll see Firefox open up later to install the theme."
        wget https://github.com/grassmunk/Chicago95/raw/master/Extras/chicago5_ie4-1.0-an%2Bfx.xpi -O "$2/chicago95_ie4_theme_yes.xpi"
        ;;
esac

clear
echo "Configuring LightDM GTK+ Greeter (the login screen program Xubuntu uses)..."
apt install lightdm-gtk-greeter lightdm -y
apt purge sddm -y
echo "[greeter]
background = #008080
theme-name = Chicago95
icon-theme-name = Chicago95
indicators = ~spacer;~session;~language;~a11y;~power
hide-user-image = true
position = 50%,center -60%,center
user-background = false" > /etc/lightdm/lightdm-gtk-greeter.conf

clear
echo "Installing the Chicago95 Plymouth Theme and setting it as the boot screen theme..."

cp -Rf ./Plymouth/Chicago95 /usr/share/plymouth/themes/
update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/Chicago95/Chicago95.plymouth 100
update-alternatives --set default.plymouth /usr/share/plymouth/themes/Chicago95/Chicago95.plymouth

clear
echo "Updating boot files go brrr..."
update-initramfs -u -k all

clear
echo "Installing sounds..."
cp -Rf ./sounds/Chicago95 /usr/share/sounds/
cp -f "./Extras/Microsoft Windows 95 Startup Sound.ogg" /usr/share/sounds/Chicago95/startup.ogg

clear
echo "Installing Backgrounds..."
cp -Rf ./Extras/Backgrounds /usr/share/Chicago95Backgrounds
cp -f ./KDE/Splash/chicago95.splashscreen/contents/splash/images/background.jpg /usr/share/Chicago95Backgrounds/background.jpg

clear
echo "Installing extra cursors system-wide..."
cp -Rf ./Cursors/* /usr/share/icons/

true



exit 0
fi

if [ "$(whoami)" == "root" ]; then
    echo "You're not meant to run it as root here."
    exit 1
fi

clear
read -p "Welcome to Chicagofier, an unofficial script to do the transformation of XFCE into the Chicago95 look.

Before we begin, huge shout-outs to grassmunk and everyone else who has contributed to Chicago95. Without all of you this wouldn't be possible to do.

You can find the original repository at https://github.com/grassmunk/Chicago95. The only thing I've made out of all of this is this mere script.

PRESS ENTER to continue. (a 'sudo password' prompt will follow, enter your normal password in it to run the script)

"

sudo bash "$0" --rootland "$chicagodir" && bash "$0" --userland "$chicagodir"
