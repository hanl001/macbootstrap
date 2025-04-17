#!/bin/bash

set -e

pushd `dirname $0` > /dev/null
project_path=`pwd -P`
popd > /dev/null
python_src_path="$project_path/python-src"
shell_src_path="$project_path/shell-src"
config_path="$project_path/config"

source $shell_src_path/base.sh
source $shell_src_path/setup.sh
source $shell_src_path/install.sh
source $shell_src_path/update.sh
source $shell_src_path/path.sh
source $shell_src_path/link.sh

function _get_full_command() {
    short=" t:test,
    tx:to_xcode_snippets_path,
    tm:to_macbootstrap_path,
    l:link,
    i:install,
    u:update"
    full=$(expr "$short" : ".* $2:\([^,]*\),.*")
    if [ ! $full ]
    then
        full=$2
    fi
    echo $full
}

function help() {
	cat <<-EOF

	Usage: hl [options]

	Valid options are:


    * about set up my mac
    
            setup                     automatically configure a new mac
            setup_mac_config          set all mac system configs
    

    * about check and install tools
    
            install                   check and install all tools
            check_brew                check brew and tools installed with brew
            check_oh_myzsh            check oh-my-zsh and some tools
            check_vim                 check vim env
            check_xcode_snippets      check xcode snippets
            check_others              check other tools that cannot be installed using brew
            check_applications        check applications use brew cask
            update                    sync macbootstrap from remote and update on-my-zsh
    
    
    * about link configs
    
            link                      link all configs
            link_git                  link git configs
            link_shell                link shell configs
            link_ranger               link ranger configs
            link_vim                  link vim configs and check Plugins
            link_lldb                 links lldb configs
    

    * about quick location path
    
            tm                        jump to macbootstrap path
            tx                        jump to xcode snippets path
    
            
    * others 
    
            help                      show this help message and exit
    
	EOF
}

action=${1:-help}
$action "$@"
