# -----------
# os agnostic
# -----------

# exports
export LIBRARY="$HOME/dungeon"
export OCIO="$LIBRARY/ocio/spi-anim/config.ocio"

# aliases
alias lh="ls -lh"
alias la="ls -a"
alias ll="ls -l"
alias lm="ls -lh -sort"

alias removeExtensions="for x in *;do mv $x ${x%*.*};done"

# functions
function pad_files {
    num=`expr match "$1" '[^0-9]*\([0-9]\+\).*'`
    paddednum=`printf "%03d" $num`
    echo ${1/$num/$paddednum}
}

function colors {
    color=16;

    while [ $color -lt 245 ]; do
        echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
        ((color++));
    done
}

# ----------
# os specifc
# ----------

if [[ `uname` == 'Darwin' ]]; then

    # environment
    export PATH=$PATH:~/bin:/Applications/ChaosGroup/V-Ray/Maya2018/bin:/Applications/Autodesk/maya2018/Maya.app/Contents/bin
    source /Users/Shared/rlm/rlmenvset.sh

    # set env for apps launched via launchpad, spotlight, and dock
    launchctl setenv LIBRARY $LIBRARY
    launchctl setenv OCIO $OCIO
    launchctl setenv PATH $PATH

    # houdini config
    if [ -d "/Applications/Houdini/Current/Frameworks/Houdini.framework/Versions/Current/Resources/" ]; then
        cd /Applications/Houdini/Current/Frameworks/Houdini.framework/Versions/Current/Resources/
        . ./houdini_setup
        cd
    fi

    # aliases
    alias showHidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideHidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

    # functions
    function transfer {
        transfer_url=$(curl -T ${1} "https://transfer.sh/"$(basename ${1}))
        echo -n $transfer_url | pbcopy
        echo -e "\nupload complete: $_blue2$transfer_url$_lightgray\n"
    }
    
elif [[ `uname` == 'Linux' ]]; then

    # environment
    export PATH=$PATH:$HOME/bin:$HOME/.local/bin

    # functions
    function supercaps {
        setxkbmap -option caps:super
    }
fi

# show screenfetch
echo -e "\n"
screenfetch -E
echo -e "\n"
