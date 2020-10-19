#!/bin/bash
# Original script by https://github.com/GermanBread
if [[ $TERM == dumb ]]; then
    exit;
fi

if [[ $(whoami) != "root" ]] ; then
    printf "[$(tput setaf 9 && tput blink)PANIC$(tput sgr0)] $(tput setaf 9)This script needs to run as root$(tput sgr0)\n";
    exit;
fi


cat << "EOF"
  _    _      _   _                 _
 | |  (_)__ _| |_| |_ __ ___ _ _ __| |
 | |__| / _` | ' \  _/ _/ _ \ '_/ _` |
 |____|_\__, |_||_\__\__\___/_| \__,_|
        |___/
    Linux Installer and Updater
    
EOF

printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)This script depends on unzip! Install that package first!$(tput sgr0)\n";

printf "Please select$(tput sgr0)\n";
printf "1: Install Lightcord\n";
printf "2: Uninstall Lightcord\n";
printf "3: Update Lightcord\n"
printf "\n";

#Repeat only if the user hasn't entered an integer...
while ! [[ $selection =~ ^[0-9]+$ ]]; 
do
    read selection;
    #if the entered value was not an integer, show this
    if ! [[ $selection =~ ^[0-9]+$ ]]; then
        sleep 1;
        printf "$(tput setaf 9)Please try again$(tput sgr0)\n";
        printf "1: Install Lightcord\n";
        printf "2: Uninstall Lightcord\n";
        printf "3: Update Lightcord\n"
        printf "\n";
    fi
done

case $selection in
    1)
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Installing Lightcord$(tput sgr0)\n";
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Downloading Lightcord zip to $(pwd && tput sgr0)\n";
    wget https://lightcord.org/api/v1/gh/releases/Lightcord/Lightcord/dev/lightcord-linux-x64.zip; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Unzipping$(tput sgr0)\n";
    unzip lightcord-linux-x64.zip -d Lightcord; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Deleting zip$(tput sgr0)\n";
    rm lightcord-linux-x64.zip; 
    prev_pwd = pwd;
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Changing directory into $(pwd)/Lightcord$(tput sgr0)\n";
    cd Lightcord; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Giving $(pwd)/lightcord executable execute permissions$(tput sgr0)\n";
    chmod +x ./lightcord; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Changing directory into ${prev_pwd}$(tput sgr0)\n";
    cd ..; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Moving $(pwd)/Lightcord folder to /opt$(tput sgr0)\n";
    mv Lightcord/ /opt/; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Deleting $(pwd)/Lightcord folder$(tput sgr0)\n";
    rm Lightcord/; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Downloading lightcord.svg icon to $(pwd && tput sgr0)\n";
    wget https://raw.githubusercontent.com/Lightcord/LightcordLogos/master/lightcord/lightcord.svg; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Moving $(pwd)/lightcord.svg file to /usr/share/pixmaps$(tput sgr0)\n";
    mv lightcord.svg /usr/share/pixmaps; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Downloading /usr/share/applications/lightcord.desktop$(tput sgr0)\n";
    wget https://raw.githubusercontent.com/PoorPocketsMcNewHold/Lightcord-PKGBUILD/master/Lightcord.desktop
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Downloading Lightcord.desktop file to $(pwd && tput sgr0)\n";
    wget https://raw.githubusercontent.com/Lightcord/Lightcord/master/Lightcord.desktop; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Moving $(pwd)/Lightcord.desktop file to /usr/share/applications$(tput sgr0)\n";
    mv Lightcord.desktop /usr/share/applications; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Giving /usr/share/Lightcord.desktop executable execute permissions$(tput sgr0)\n";
    chmod +x /usr/share/applications/Lightcord.desktop;
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Cleaning up$(tput sgr0)\n";
    rm -rf Lightcord;
    printf "[$(tput setaf 10 && tput blink)FINISH$(tput sgr0)] Installation complete\n"
    ;;

    2)
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Uninstalling Lightcord$(tput sgr0)\n";
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Deleting /opt/Lightcord$(tput sgr0)\n";
    rm -r /opt/Lightcord;
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Deleting /usr/share/pixmaps/lightcord.svg$(tput sgr0)\n";
    rm /usr/share/pixmaps/lightcord.svg;
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Deleting /usr/share/Lightcord.desktop$(tput sgr0)\n";
    rm /usr/share/applications/Lightcord.desktop;
    #printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Deleting /home/*/.local/share/applications/Lightcord.desktop$(tput sgr0)\n";
    #rm /home/*/.local/share/applications/Lightcord.desktop;
    printf "[$(tput setaf 10 && tput blink)FINISH$(tput sgr0)] Uninstall complete\n"
    ;;

    3)
    #Uninstall
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Updating Lightcord$(tput sgr0)\n";
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Deleting /opt/Lightcord$(tput sgr0)\n";
    rm -r /opt/Lightcord;
    #Install
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Downloading Lightcord zip to $(pwd && tput sgr0)\n";
    wget https://lightcord.org/api/v1/gh/releases/Lightcord/Lightcord/dev/lightcord-linux-x64.zip; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Unzipping$(tput sgr0)\n";
    unzip lightcord-linux-x64.zip -d Lightcord; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Deleting zip$(tput sgr0)\n";
    rm lightcord-linux-x64.zip; 
    prev_pwd = pwd;
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Changing directory into $(pwd)/Lightcord$(tput sgr0)\n";
    cd Lightcord; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Giving $(pwd)/lightcord executable execute permissions$(tput sgr0)\n";
    chmod +x ./lightcord; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Changing directory into ${prev_pwd}$(tput sgr0)\n";
    cd ..; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Moving $(pwd)/Lightcord folder to /opt$(tput sgr0)\n";
    mv Lightcord/ /opt/; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Deleting $(pwd)/Lightcord folder$(tput sgr0)\n";
    rm Lightcord/; 
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 7)Cleaning up$(tput sgr0)\n";
    rm -rf Lightcord;
    printf "[$(tput setaf 10 && tput blink)FINISH$(tput sgr0)] Update complete\n"
    ;;

    *)
    printf "[$(tput setaf 12 && tput blink)INFO$(tput sgr0)] $(tput setaf 12)Exiting$(tput sgr0)\n";
    ;;
esac
