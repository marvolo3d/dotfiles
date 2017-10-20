# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.

# source aliases
test -s ~/.alias && . ~/.alias || true

export EDITOR='nano'

# OCIO
export OCIO="$LIBRARY/ocio_config/spi-anim/config.ocio"

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

# general
export LIBRARY="$HOME/library"
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

# initialize houdini env
cd /opt/hfs/
. ./houdini_setup &> /dev/null
cd ~

# set env for RLM
export foundry_LICENSE="5053@localhost"
export peregrinel_LICENSE="5053@localhost"
export RLM_LICENSE=/opt/rlm
export PATH=$PATH:foundry_LICENSE:peregrinel_LICENSE:solidangle_LICENSE:RLM_LICENSE

# transparent blur konsole
konsolex=$(qdbus | grep konsole | cut -f 2 -d\ )
if [ -n "$konsolex" ]; then
    for konsole in `xdotool search --class konsole`; do
        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $konsole;
    done
fi

echo -e "\n\n"
screenfetch #display screenfetch
echo -e "\n\n"
