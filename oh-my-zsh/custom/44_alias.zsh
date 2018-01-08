# -------
# aliases
# -------

alias lh="ls -lh"
alias la="ls -a"
alias ll="ls -l"
alias lm="ls -lh -sort"

alias mmv='noglob zmv -W' #no need for '' with zmv
# mmv *.c.orig orig/*.

alias dl="cd ~/Downloads"

alias removeExtensions="for x in *;do mv $x ${x%*.*};done"

if [[ `uname` == 'Darwin' ]]; then
    # osx-specific aliases
    alias showHidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideHidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

elif [[ `uname` == 'Linux' ]]; then

    if [ -z "$(hostname | grep stellar)" ]; then

        alias restartX="sudo systemctl restart sddm"

        alias vrlctl="/usr/ChaosGroup/VRLService/OLS/vrlctl" #made alias because appending to PATH wasn't working

        alias rv="/opt/rv/bin/rv"
        alias mari="/opt/mari/mari &"
        alias nuke="/opt/nuke/Nuke* &"
        alias maya="/usr/autodesk/maya2018/bin/maya2018 -nosplash &"
        alias mayapy="/usr/autodesk/maya2018/bin/mayapy"

        alias sshmac="ssh marvolo@macpro.local"
        alias sshxeon="ssh marvolo@xeon-ws.local"
        alias sshx99="ssh marvolo@titan-x99.local"

    fi

    alias open="dolphin . > /dev/null 2>&1 &!"
    alias gpuwatch="watch -n 1 nvidia-smi"
    alias mhz="watch -n1 'cat /proc/cpuinfo | grep -i mhz'"
fi
