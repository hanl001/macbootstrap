function hl() {
    command=`bash "$MACBOOTSTRAP_ROOT/manager.sh" _get_full_command "$1"`
    if [ "$command" = "to_xcode_snippets_path" ]
    then
        project_path=`bash "$MACBOOTSTRAP_ROOT/manager.sh" get_xcode_snippets_path`
        echo change dir to $project_path
        cd $project_path
    elif [ "$command" = "to_macbootstrap_path" ]
    then
        echo change dir to $MACBOOTSTRAP_ROOT
        cd $MACBOOTSTRAP_ROOT
    else
        bash "$MACBOOTSTRAP_ROOT/manager.sh" "$@"
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

# 启动 AI CLI 前，先把 ~/.agents/skills 软链补进各运行时的 skill 目录，
# 这样卸装 Claude 桌面 App 后这些 skill 仍被 Claude Code / Codex 自动识别，
# 且新增 skill 无需手动 ln。详见 shell-src/global/agents_skills_sync.sh
function claude() {
    bash "$MACBOOTSTRAP_ROOT/shell-src/global/agents_skills_sync.sh" >/dev/null 2>&1
    command claude "$@"
}

function codex() {
    bash "$MACBOOTSTRAP_ROOT/shell-src/global/agents_skills_sync.sh" >/dev/null 2>&1
    command codex "$@"
}
