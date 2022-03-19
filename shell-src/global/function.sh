function hl() {
    command=`sh $MACBOOTSTRAP_ROOT/manager.sh _get_full_command "$1"`
    if [ "$command" = "to_xcode_snippets_path" ]
    then
        project_path=`sh $MACBOOTSTRAP_ROOT/manager.sh get_project_path`
        echo change dir to $project_path
        cd $project_path
    elif [ "$command" = "to_macbootstrap_path" ]
    then
        echo change dir to $MACBOOTSTRAP_ROOT
        cd $MACBOOTSTRAP_ROOT
    else
        sh $MACBOOTSTRAP_ROOT/manager.sh $1 $2 $3 $4 $5 $6 $7 $8 $9
    fi
}

function hs() {
    emulate -L zsh
    local message=$1
    history | grep --color=always -i "$message" | awk '{$1="";print $0}' |
    sort | uniq -c | sort -rn | awk '{$1="";print NR " " $0}' |
    tee ~/.histfile_color_result | gsed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" |
    awk '{$1="";print "function " NR "() {" $0 "; echo \": $(date +%s):0;"$0"\" >> ~/.histfile }"}' | 
    {while read line; do eval $line &>/dev/null; done}
    cat ~/.histfile_color_result | sed '1!G;h;$!d' 
}
