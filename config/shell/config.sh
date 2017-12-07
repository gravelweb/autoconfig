#!/bin/bash

# install oh-my-zsh if missing
if [[ -d ~/.oh-my-zsh ]]; then
    echo "Info: oh my zsh already installed."
    # TODO: Update oh-my-zsh
else
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | zsh
    chsh -s $(which zsh)
fi

# install powerline fonts
(cd ~/.fonts && ./install.sh)

terminal__profile=$(dconf list /org/gnome/terminal/legacy/profiles:/)
terminal__profile=/org/gnome/terminal/legacy/profiles:/${terminal__profile}

# set terminal colour to solarized dark
dconf write ${terminal__profile}use-theme-colors false
dconf write ${terminal__profile}background-color "'rgb(0,43,54)'"
dconf write ${terminal__profile}foreground-color "'rgb(131,148,150)'"
dconf write ${terminal__profile}palette "['rgb(7,54,66)', 'rgb(220,50,47)', 'rgb(133,153,0)', 'rgb(181,137,0)', 'rgb(38,139,210)', 'rgb(211,54,130)', 'rgb(42,161,152)', 'rgb(238,232,213)', 'rgb(0,43,54)', 'rgb(203,75,22)', 'rgb(88,110,117)', 'rgb(101,123,131)', 'rgb(131,148,150)', 'rgb(108,113,196)', 'rgb(147,161,161)', 'rgb(253,246,227)']"
# set terminal font
dconf write ${terminal__profile}font "'Source Code Pro for Powerline Regular 10'"
# set terminal miscellaneous
dconf write ${terminal__profile}audible-bell false
# dconf schema from https://git.gnome.org/browse/gnome-terminal/tree/src/org.gnome.Terminal.gschema.xml
