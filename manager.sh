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
source $shell_src_path/link.sh

function help() {
	cat <<-EOF

	Usage: manager.sh [options]

	Valid options are:

        setup                     setup all config about mac

        install                   check and install all tools

        update                    update config

        link                      link all config
        
        help                      show this help message and exit

	EOF
}

action=${1:-help}
$action "$@"
