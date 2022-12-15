#!/bin/sh

# This script is a certified and copyrighted property of raping.me
# Refactoring it without the developer's (exhaust) agreement is prohibited!

# exhaust 2022


# Installation checks (

    # flameshot

    if command -v flameshot; then
        echo "[LOG] Flameshot installed."
    else
        echo "[ERR] Please install flameshot before proceeding!"
        exit 0
    fi

    # xclip

    if command -v xclip; then
        echo "[LOG] Xclip installed."
    else
        echo "[ERR] Please install xclip before proceeding!"
        exit 0
    fi

    # kdialog

    if command -v kdialog; then
        echo "[LOG] Kdialog installed."
    else
        echo "[ERR] Please install kdialog before proceeding!"
        exit 0
    fi

    # xbindkeys

    if command -v xbindkeys; then
        echo "[LOG] Xbindkeys installed."
    else
        echo "[ERR] Please install xbindkeys before proceeding!"
        exit 0
    fi
# )

# Fetching args (

    echo ""

    echo "To install raping.me flameshot extension, input your information below."
    echo "You can exit the installator anytime by clicking [CTRL + C]."

    echo ""

    echo "What's your upload token?"
    read tokenX
    echo ""

    echo "Okay, now what's your FULL DOMAIN (example: iuse.raping.me [DON'T INCLUDE THE \"HTTPS://\"] )"
    read domainX
    echo ""
# )

# Fetching the screenshot shortcut (
    
        echo "Press the shortcut you want to use."      
        shortcutX=$( { xbindkeys --key 2>/dev/null || echo 0; } | tail -n 1 )

# )


# Installation (

    # Creating the config directory

    mkdir $HOME/rapingmecfg > /dev/null

    # Writing the shortcut script to xbindkeys config 

    awk -v n=3 'NR==FNR{total=NR;next} FNR==total-n+1{exit} 1' $HOME/.xbindkeysrc $HOME/.xbindkeysrc > /dev/null

    echo "\"sh $HOME/rapingmecfg/screenshot\"
    $shortcutX" | tee -a "$HOME/.xbindkeysrc" > /dev/null

    # Checking if the xbindkeys config file exists

    xbindkeys -d > $HOME/.xbindkeysrc > /dev/null

#    if test -f "$HOME/.xbindkeysrc"; then
#        echo ""
#    else
#        xbindkeys -d > ~/.xbindkeysrc
#    fi

    echo "##################################
# End of xbindkeys configuration #
##################################" | tee -a "$HOME/.xbindkeysrc" > /dev/null

    # Writing the flameshot script to the config directory

    echo "#!/bin/sh

token=\"$tokenX\"
url=\"https://$domainX/index.php\"
temp=\"/tmp/image.png\"

flameshot gui -r > \$temp

if [[ \$(file --mime-type -b \$temp) != \"image/png\" ]]; then
    rm \$temp

    kdialog --passivepopup \"Screenshot aborted\" --title \$url && exit 1
fi
image_url=\$(curl -s -F \"sharex=@\${temp}\" -F \"token=\${token}\" \"\${url}\")
echo -n \$image_url | xclip -sel c
kdialog --passivepopup \"Image URL copied to clipboard\" \"raping.me\" --imgbox $temp --title raping.me
rm \$temp" | tee -a "$HOME/rapingmecfg/screenshot" > /dev/null

# )

# Ending the installation (
    echo ""
    echo "The script was installed correctly! If you see any errors, create a help thread on our discord server."
    xbindkeys
# )
