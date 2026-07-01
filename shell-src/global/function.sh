# hl 短命令 → 全名（命令很少，直接 case，省掉原来那次 manager.sh 子进程解析）
function _hl_resolve() {
    case "$1" in
        tx) echo to_xcode_snippets_path ;;
        l)  echo link ;;
        i)  echo install ;;
        u)  echo update ;;
        *)  echo "$1" ;;
    esac
}

function hl() {
    local action=`_hl_resolve "${1:-help}"`
    # cd 类命令必须在交互 shell 内执行（子进程 cd 不生效），其余解析成全名后转交 manager.sh
    case "$action" in
        to_xcode_snippets_path)
            local project_path=`bash "$MACBOOTSTRAP_ROOT/manager.sh" get_xcode_snippets_path`
            echo "change dir to $project_path"
            cd "$project_path" ;;
        *)
            bash "$MACBOOTSTRAP_ROOT/manager.sh" "$action" "${@:2}" ;;
    esac
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

function hermes() {
    bash "$MACBOOTSTRAP_ROOT/shell-src/global/agents_skills_sync.sh" >/dev/null 2>&1
    command hermes "$@"
}
