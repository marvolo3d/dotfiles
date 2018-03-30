# -------
# aliases
# -------

alias ll="ls -lh"
alias la="ls -a"
alias lm="ls -lh -sort"
alias cdl="cd $1; lm"
alias rf="rm -rf"

alias mmv='noglob zmv -W' # no need for '' with zmv
# usage: mmv *.c.orig orig/*.

alias dl="cd ~/Downloads"

alias removeExtensions="for x in *;do mv $x ${x%*.*};done"

alias sshmac="ssh marvolo@macpro.local"
alias sshxeon="ssh marvolo@xeon-ws.local"
alias sshx99="ssh marvolo@titan-x99.local"

if [[ `uname` == 'Darwin' ]]; then
    # osx-specific aliases
    alias showHidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideHidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    alias nuke="/Applications/Nuke.app/Contents/MacOS/Nuke*"
    alias dmgmount="hdiutil attach"
    alias dmgumount="hdiutil detach"
    alias maya="open -a maya"
    alias zbrush="open -a zbrush"
    alias nvidiaupdate="bash <(curl -s https://raw.githubusercontent.com/Benjamin-Dobell/nvidia-update/master/nvidia-update.sh)"

elif [[ `uname` == 'Linux' ]]; then

    if [ -z "$(hostname | grep stellar)" ]; then

        alias restartX="sudo systemctl restart sddm"

        alias vrlctl="/usr/ChaosGroup/VRLService/OLS/vrlctl" #made alias because appending to PATH wasn't working

        alias rv="/opt/rv/bin/rv"
        alias mari="/opt/mari/mari &"
        alias nuke="/opt/nuke/Nuke* &"
        alias maya="/usr/autodesk/maya2018/bin/maya2018 -nosplash &"
        alias mayapy="/usr/autodesk/maya2018/bin/mayapy"

    fi

    alias open="xdg-open"
    alias gpuwatch="watch -n 1 nvidia-smi"
    alias mhz="watch -n1 'cat /proc/cpuinfo | grep -i mhz'"
fi
