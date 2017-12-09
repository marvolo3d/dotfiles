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

    # -----------
    # environment
    # -----------

    if [ ! -z $(echo $PATH | grep $HOME/bin) ]; then
        export PATH=$PATH:$HOME/bin
    fi

    if [ ! -z $(echo $PATH | grep $HOME/.local/bin) ]; then
        export PATH=$PATH:$HOME/.local/bin
    fi

    # maya
    export MAYA_AUTOSAVE_FOLDER="/var/tmp/maya_auto"

    # yeti
    export YETI_TMP="/var/tmp/yeti"
    export YETI_HOME="/opt/yeti"
    export RMAN_PROCEDURALS_PATH="/opt/yeti/bin" # for renderman
    export REDSHIFT_MAYAEXTENSIONSPATH="/opt/yeti/plug-ins"

    # nuke
    export NUKE_TEMP_DIR="/var/tmp/nuke"
    export NUKE_DISK_CACHE="/var/tmp/nuke/viewer"
    export NUKE_DISK_CACHE_GB=2

    # mari
    # export MARI_COLORSPACE_USER_INTERFACE_MODE=2 #advanced color space options
    # export MARI_SCRIPT_PATH= <list of mari script paths>

    export PROJECTS="$HOME/projects"

    # renderman
    # export RMSTREE=/opt/pixar/RenderManForMaya-21.3-maya2017
    # export RMANTREE=/opt/pixar/RenderManProServer-21.3
    # export MAYA_RENDER_DESC_PATH=$RMSTREE/etc/rmanRenderer.xml #for command line renders
    # export PATH=$PATH:$RMANTREE/bin #:/usr/ChaosGroup/V-Ray/Maya2017-x64/bin

    # arnold
    # export PATH=$PATH:/opt/solidangle/mtoa/2017/bin #for maketx

    # al shaders
    # export ALSHADERS_INSTALL="/opt/alShaders"
    # export ARNOLD_PLUGIN_PATH=$ALSHADERS_INSTALL/bin
    # export MTOA_TEMPLATES_PATH=$ALSHADERS_INSTALL/ae
    # export MAYA_CUSTOM_TEMPLATE_PATH=$ALSHADERS_INSTALL/aexml

    # redshift
    export REDSHIFT_COREDATAPATH="/opt/redshift" #_experimental"
    export REDSHIFT_LOCALDATAPATH="$HOME/redshift"
    export REDSHIFT_PREFSPATH="$HOME/redshift/preferences.xml"
    export REDSHIFT_LICENSEPATH="$HOME/redshift"

    # vray
    export PATH=$PATH:/usr/ChaosGroup/V-Ray/Maya2018-x64/bin
    export VRAY_VFB_SRGB=2 #off
    #export VRAY_VFB_SRGB=1 #on
    #export VRAY_VFB_OCIO=2 #off
    export VRAY_VFB_OCIO=1 #on

    # ---------------
    # end environment
    # ---------------

    # aliases
    alias gpu="konsole -e watch -n 1 nvidia-smi &> /dev/null"

    alias vrlctl="/usr/ChaosGroup/VRLService/OLS/vrlctl" #made alias because appending to PATH wasn't working

    alias rv="/opt/rv/bin/rv"
    alias mari="/opt/mari/mari &"
    alias nuke="/opt/nuke/Nuke11.0 -b"
    alias maya="/usr/autodesk/maya2018/bin/maya2018 -nosplash &"

    # functions
    function supercaps {
        setxkbmap -option caps:super
    }

    # transparent blur konsole
    konsolex=$(qdbus | grep konsole | cut -f 2 -d\ )
    if [ -n "$konsolex" ]; then
        for konsole in `xdotool search --class konsole`; do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $konsole;
        done
    fi

    function FTPmount {
        curlftpfs ftp://tomnorman.ca /mnt/tomnorman_ca/goodies -o user=goodies@tomnorman.ca:Fideliox1!
        curlftpfs ftp://tomnorman.ca /mnt/tomnorman_ca/the_abyss -o user=marvolo@tomnorman.ca:Fideliox1!
        curlftpfs ftp://tomnorman.ca /mnt/tomnorman_ca/public -o user=public@tomnorman.ca:Fideliox1!
    }

    function pset {
    	export PROJECT=$(pwd)
    }

    function cdp {
      pname="$1"
      cd "${HOME}/projects/${pname}"
    }

    function freespace {
        sudo btrfs fi usage $1
    }

    function x264_encode {
        filename="$1"
        filename="${filename%.*}"

        if [ -z "$2" ]; then
            framerate=24
        else
            framerate=$2
        fi

        echo -e "encoding ${filename} at ${framerate} fps"

        # ffmpeg -i "$1" -r $framerate -c:v libx264 -preset slow -crf 18 -pix_fmt yuv420p "${filename}_x264.mp4"
        ffmpeg -i "$1" -r $framerate -c:v libx264 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -preset veryslow -crf 18 -pix_fmt yuv420p "${filename}_x264.mp4"

        bell
    }

    function transfer {
        transfer_url=$(curl -T ${1} "https://transfer.sh/"$(basename ${1}))
        echo -n $transfer_url | xclip -selection clipboard #copy link to clipboard
        echo -e "\nupload complete: $_blue2$transfer_url$_lightgray\n"
        notify-send "$transfer_url" -t 2000 #notify

        bell
    }

    function tn_transfer {
        # mount site if not already
        if [ -z "$(mount | grep tomnorman_ca/the_abyss)" ]; then
            FTPmount
        fi

        if [ "$1" == "-r" ]; then
            random=1
            infile="$2"
        elif [ -z "$2" ]; then
            random=0
            infile="$1"
        fi

        filename="$(basename $infile)"
        targetdir="/mnt/tomnorman_ca/the_abyss/"

        if [ $random == 1 ]; then
            pass=0

            while [ $pass -lt 1 ]
            do
                extension="${filename##*.}"
                # noun="$(shuf -n1 /usr/share/wordnet-3.0/dict/noun.exc)"
                noun="$(cat ~/Documents/animals | shuf -n1 )"

                initial="$(echo $noun | head -c 1)" # get an adjective that starts with the same first letter
                # adj="$(cat /usr/share/wordnet-3.0/dict/adj.exc | grep "^$initial" | shuf -n1 | awk '{print $2}')"
                adj="$(cat ~/Documents/adjectives | grep -i "^$initial" | shuf -n1)"

                # nounrand[0]="$(echo $noun | awk '{print $1}')"
                # nounrand[1]="$(echo $noun | awk '{print $2}')"
                # rand=$[ $RANDOM % 2 ]
                # noun="${nounrand[$rand]}"

                filename="${adj}${noun^}.${extension}"

                if [ ! -f "$targetdir$filename" ]; then
                    pass=1
                fi
            done

        fi

        cp "$infile" $targetdir/$filename

        chmod 655 "$targetdir/$filename"

        result="http://tomnorman.ca/the_abyss/${filename}"

        echo $result

        echo -n $result | xclip -selection clipboard #copy link to clipboard

        bell

        notify-send "uploaded as fuck $result" -t 2000
    }

    function vdenoise_anim {
        vdenoise -inputFile="${1}" -useGpu=2 -abortOnOpenCLError=1
        bell
    }

    function bell {
        mplayer "/usr/share/sounds/freedesktop/stereo/bell.oga" &> /dev/null
    }

    function update_firefox {
        wget -qO - "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" | sudo tar xjf - -C /opt

        echo "firefox updated succesfully"

        bell
    }

    function disable_caps {
        setxkbmap -option caps:none
    }

    function sound_fix {
        killall pulseaudio
        killall spotify
        killall plasmashell

        xrandr --output DP-2 --off
        xrandr --output DP-2 --auto
        xrandr --output DP-2 --left-of HDMI-0

        kstart plasmashell > /dev/null 2>&1

        sleep 3

        spotify > /dev/null 2>&1 &
    }

    function vray_check {
        echo
        echo

        echo "vray render slave dr check"

        macpro="$(vraydr_check -host=macpro -port=20207 2>&1)"
        xeon="$(vraydr_check -host=xeon-ws -port=20207 2>&1)"

        if [ -z "$(echo $macpro | grep -i ready)" ]; then
            macpro_result="\e[38;5;160mfailed: \e[38;5;244m$macpro"
        else
            macpro_result="\e[38;5;76mready!\e[38;5;244m"
        fi

        if [ -z "$(echo $xeon | grep -i ready)" ]; then
            xeon_result="\e[38;5;160mfailed: \e[38;5;244m$xeon"
        else
            xeon_result="\e[38;5;76mready!\e[38;5;244m"
        fi

        echo -e "\e[38;5;208mmacpro\e[38;5;244m  | $macpro_result "
        echo -e "\e[38;5;208mxeon-ws\e[38;5;244m | $xeon_result "
        echo
        echo
    }

    function startNukeRenderServer {
        /opt/nuke/python /opt/nuke/pythonextensions/site-packages/foundry/frameserver/nuke/runframeserver.py --numworkers=2 --nukeworkerthreads=24 --nukeworkermemory=16384 --workerconnecturl=tcp://titan-x99:5560 --nukepath/opt/nuke/Nuke11.0
    }

fi

# show screenfetch
echo -e "\n"
screenfetch -E
echo -e "\n"
