#!/bin/bash

#sync atom, and install package-sync package

#maya preferences
#setup path to maya prefs based on uname (mac/lin)
#symlink maya.env and usersetup.py

#houdini preferences
#linux: ~/Houdini16.0
#osx: ~/Library/Preferences/houdini/16.0


#create symlinks to install dir and /users/shared/zbrushdata for brushes, materials, plugins from $LIBRARY (if library exists)

# install zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install custom zsh plugins
# git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# install zsh spaceship theme
#curl -o - https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.zsh | zsh

# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
