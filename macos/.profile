# PROMPT COLORING. https://cwgoover.github.io/2016/07/26/linux-prompt/

_blue="\\033[38;5;76m"
_blue2="\\033[38;5;154m"
_purp="\\033[38;5;98m"
_gray="\\033[38;5;240m"
_lightgray="\\033[38;5;244m"


export PS1="$_blue\u$_blue2@\h $_purp\W $_gray$ $_lightgray"

export PATH=$PATH:~/bin:/Applications/ChaosGroup/V-Ray/Maya2018/bin:/Applications/Autodesk/maya2018/Maya.app/Contents/bin

export LIBRARY="$HOME/dungeon"
export OCIO="$LIBRARY/ocio/spi-anim/config.ocio"

# set variables for apps launched from launchpad, dock, spotlight
launchctl setenv LIBRARY $LIBRARY
launchctl setenv OCIO $OCIO
launchctl setenv PATH $PATH

# aliases
alias lh="ls -lh"
alias la="ls -a"
alias ll="ls -l"
alias lm="ls -lh -sort"

alias showHidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -Gh'

echo -e "\n"
screenfetch -E
echo -e "\n"

cd /Applications/Houdini/Current/Frameworks/Houdini.framework/Versions/Current/Resources/
. ./houdini_setup
cd

function transfer {

    transfer_url=$(curl -T ${1} "https://transfer.sh/"$(basename ${1}))
    echo -n $transfer_url | pbcopy
    echo -e "\nupload complete: $_blue2$transfer_url$_lightgray\n"
    #notify-send "$transfer_url" -t 2000 #notify
}
