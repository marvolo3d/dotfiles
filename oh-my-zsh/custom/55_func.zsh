# ---------
# functions
# ---------

if [[ `uname` == "Darwin" ]]; then
    echo "none for osx" > /dev/null
elif [[ `uname` == "Linux" ]]; then

    function supercaps {
        setxkbmap -option caps:super
    }

    function disable_caps {
        setxkbmap -option caps:none
    }

    function mario_notify {
        NOTIFY=$(ls ~/.notif/mario_N64 | shuf -n1) # choose random
        NPATH="${HOME}/.notif/mario_N64/${NOTIFY}"
        paplay $NPATH &!
    }

    function update_firefox {
        wget -qO - "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" | sudo tar xjf - -C /opt

        echo "firefox updated succesfully"

        mario_notify
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

        macpro="$(vraydr_check -host=macpro.local -port=20207 2>&1)"
        xeon="$(vraydr_check -host=xeon-ws.local -port=20207 2>&1)"

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

    function tn_transfer {
        # mount site
        mftp -q

        if [ "$1" = "-r" ]; then
            random=1
            infile="$2"
        elif [ -z "$2" ]; then
            random=0
            infile="$1"
        fi

        filename="$(basename $infile)"
        targetdir="/mnt/tomnorman_ca/the_abyss/"

        if [ $random = 1 ]; then
            pass=0

            while [ $pass -lt 1 ]
            do
                extension="${filename##*.}"
                # noun="$(shuf -n1 /usr/share/wordnet-3.0/dict/noun.exc)"
                noun="$(cat /home/marvolo/Documents/animals | shuf -n1 )"

                initial="$(echo $noun | head -c 1)" # get an adjective that starts with the same first letter
                # adj="$(cat /usr/share/wordnet-3.0/dict/adj.exc | grep "^$initial" | shuf -n1 | awk '{print $2}')"
                adj="$(cat /home/marvolo/Documents/adjectives | grep -i "^$initial" | shuf -n1)"

                # nounrand[0]="$(echo $noun | awk '{print $1}')"
                # nounrand[1]="$(echo $noun | awk '{print $2}')"
                # rand=$[ $RANDOM % 2 ]
                # noun="${nounrand[$rand]}"
                filename="${adj}${(C)noun}.${extension}"

                if [ ! -f "$targetdir$filename" ]; then
                    pass=1
                fi
            done

        fi

        cp "$infile" $targetdir/$filename

        chmod 655 "$targetdir/$filename"

        result="http://tomnorman.ca/the_abyss/${filename}"

        echo $result #to stdout
        echo -n "$result" | xclip -selection clipboard #copy link to clipboard

        notify-send "share it with the world." " $result" -t 2000

        mario_notify

    } #to be made os-agnostic eventually

    function vdenoise_anim {
        vdenoise -inputFile="${1}" -useGpu=2 -abortOnOpenCLError=1
        mario_notify
    } #vray vdenoise

    function mftp {
        # -q flag is quiet
        if [ ! -e "$HOME/.netrc" ]; then
            echo "ERROR: no .netrc for ftp credentials - aborting FTP mounts"
            return 1
        fi

        if [ -z "$(mount | grep tomnorman_ca)" ]; then
            curlftpfs tomnorman-ca3 /mnt/tomnorman_ca
            if [ ! "$1" = "-q" ]; then
                 echo "mounted tomnorman.ca at /mnt/tomnorman_ca/"
            fi
        else
            if [ ! "$1" = "-q" ]; then
                 echo "tomnorman.ca already mounted at /mnt/tomnorman_ca/"
            fi
        fi
    }

fi

# -----------
# os agnostic
# -----------

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

function transfer {
    transfer_url=$(curl -T ${1} "https://transfer.sh/"$(basename ${1}))

    echo -e "\nupload complete: $_blue2$transfer_url$_lightgray\n"
    if [[ `uname` == 'Linux' ]]; then
        echo -n $transfer_url | xclip -selection clipboard
        notify-send "transfer.sh" "$transfer_url" -t 1500 #notify
        mario_notify
    elif [[ `uname` == 'Darwin' ]]; then
        echo -n $transfer_url | pbcopy
    fi
}

function pset {
    export PROJECT=$(pwd)
}

function cdp {
  pname="$1"
  cd "${HOME}/projects/${pname}"
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

    if [[ `uname` == 'Linux' ]]; then
        mario_notify
    fi
}

function reloadFunc {
    . ~/.oh-my-zsh/custom/55_func.zsh
}
