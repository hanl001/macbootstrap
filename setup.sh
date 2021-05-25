#!bin/bash

function exe_cmd() {
    echo $1
    eval $1
}

xcode-select --install
git clone "git@github.com:hanl001/macbootstrap.git" ~/.macbootstrap
exe_cmd "cd ~/.macbootstrap"
exe_cmd "bash install.sh"
exe_cmd "bash link.sh"
