#!/bin/bash

set -e

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
SCRIPTFILE=`basename $0`

function exe_cmd()
{
	echo $1
	eval $1
}

# link git config
exe_cmd "mv ~/.gitconfig ~/.gitconfig_backup"
exe_cmd "ln -sf ~/.macbootstrap/git-config/_gitconfig ~/.gitconfig"
exe_cmd "ln -sf ~/.macbootstrap/git-config/_gitignore_global ~/.gitignore_global"

# link shell config
exe_cmd "mv ~/.zshrc ~/.zshrc_backup"
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_zshrc ~/.zshrc"

exe_cmd "mv ~/.bashrc ~/.bashrc_backup"
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_bashrc ~/.bashrc"

exe_cmd "mv ~/.bash_profile  ~/.bash_profile_backup"
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_bash_profile ~/.bash_profile" 

exe_cmd "mv ~/.inputrc  ~/.inputrc_backup"
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_inputrc ~/.inputrc"
