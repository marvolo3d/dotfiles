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
    cd /Applications/Houdini/Current/Frameworks/Houdini.framework/Versions/Current/Resources/
    . ./houdini_setup
    cd

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

    # do linux things

fi

# show screenfetch
echo -e "\n"
screenfetch -E
echo -e "\n"
