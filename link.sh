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
exe_cmd "ln -sf ~/.macbootstrap/git-config/_gitconfig ~/.gitconfig"
exe_cmd "ln -sf ~/.macbootstrap/git-config/_gitignore_global ~/.gitignore_global"


# link shell config
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_zshrc ~/.zshrc"
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_bashrc ~/.bashrc"
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_bash_profile ~/.bash_profile" 
exe_cmd "ln -sf ~/.macbootstrap/sh-config/_inputrc ~/.inputrc"


# link ranger config
exe_cmd "ln -sf ~/.macbootstrap/tool-config/ranger/commands.py ~/.config/ranger/commands.py"
exe_cmd "ln -sf ~/.macbootstrap/tool-config/ranger/commands_full.py ~/.config/ranger/commands_full.py"
exe_cmd "ln -sf ~/.macbootstrap/tool-config/ranger/rc.conf ~/.config/ranger/rc.conf"
exe_cmd "ln -sf ~/.macbootstrap/tool-config/ranger/rifle.conf ~/.config/ranger/rifle.conf"
exe_cmd "ln -sf ~/.macbootstrap/tool-config/ranger/scope.sh ~/.config/ranger/scope.sh"

# link lldb config
exe_cmd "ln -sf ~/.macbootstrap/tool-config/lldb/_lldbinit ~/.lldbinit"

