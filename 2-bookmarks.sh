#!/usr/bin/env bash

# http://superuser.com/questions/244189/bashrc-how-to-know-x-window-is-available-or-not
if [ -n "$DISPLAY" ]; then

    echo "==> Remove nautilus bookmarks"
    echo "enabled=false" > "$HOME/.config/user-dirs.conf"


    echo "XDG_DESKTOP_DIR=\"\$HOME/Desktop\"" > list.tmp
    
    if [ ! -e $HOME/.config/user-dirs.dirs.bak ]; then
      cp $HOME/.config/user-dirs.dirs $HOME/.config/user-dirs.dirs.bak
    fi
    mv list.tmp  $HOME/.config/user-dirs.dirs
    

    rm -fr "$HOME/Documents"
    rm -fr "$HOME/Downloads"
    rm -fr "$HOME/Music"
    rm -fr "$HOME/Pictures"
    rm -fr "$HOME/Public"
    rm -fr "$HOME/Templates"
    rm -fr "$HOME/Videos"


else
    echo "This script should be execute inside a GUI terminal"
fi
