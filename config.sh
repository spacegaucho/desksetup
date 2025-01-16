#!/bin/bash
# Files
FILE_BASHALIASES="./files/confs/.bash_aliases"
FILE_BASHRC="./files/confs/.bashrc"
FILE_STARSHIPTOML="./files/confs/starship.toml"
FILE_KREWINSTALL="./files/krewcurlinstall.sh"

# Urls
URL_LIGHLINE="https://github.com/itchyny/lightline.vim"

# Other
GIT_REPO="https://github.com/spacegaucho/desksetup"
DIR_GIT_REPO="${HOME}/git/desksetup"
COMMAND_OUT="/tmp/desksetup.log"
BACKUP_SFX=".$(date +%s).bk"

## Set newt color palette for dialogs
NEWT_COLORS_0='
    root=,blue
'
NEWT_COLORS_1='
    root=,blue
    checkbox=,blue
    entry=,blue
    label=blue,
    actlistbox=,blue
    helpline=,blue
    roottext=,blue
    emptyscale=blue
    disabledentry=blue,
'
NEWT_COLORS_2='
    root=green,black
    border=green,black
    title=green,black
    roottext=white,black
    window=green,black
    textbox=white,black
    button=black,green
    compactbutton=white,black
    listbox=white,black
    actlistbox=black,white
    actsellistbox=black,green
    checkbox=green,black
    actcheckbox=black,green
'
NEWT_COLORS_3='
    root=white,black
    border=black,lightgray
    window=lightgray,lightgray
    shadow=black,gray
    title=black,lightgray
    button=black,cyan
    actbutton=white,cyan
    compactbutton=black,lightgray
    checkbox=black,lightgray
    actcheckbox=lightgray,cyan
    entry=black,lightgray
    disentry=gray,lightgray
    label=black,lightgray
    listbox=black,lightgray
    actlistbox=black,cyan
    sellistbox=lightgray,black
    actsellistbox=lightgray,black
    textbox=black,lightgray
    acttextbox=black,cyan
    emptyscale=,gray
    fullscale=,cyan
    helpline=white,black
    roottext=lightgrey,black
'
export NEWT_COLORS=$NEWT_COLORS_2
# vi: ft=bash
