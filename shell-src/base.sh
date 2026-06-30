function exe_cmd() {
    log_run "$1"
    eval $1
}

function _selftest() {
    echo "call test"
}

function log_run() {
    _log "Run: $1"
}

function log_todo() {
    _log "Todo: $1"
}

function log_error() {
    _log "Error: $1"
}

function log_info() {
    _log "Info: $1"
}

function _log() {
    echo "`date +[%H:%M:%S]` $1"
}

# 在指定 git 仓库内安全 pull --rebase：仅当确有本地改动时才 stash，
# pull 后再 pop，避免「无改动时 stash pop 报错」与无脑 pop 留下脏状态。
function _pull_rebase_safely() {
    local dir="$1"
    cd "$dir" || { log_error "cd $dir 失败"; return 1; }
    local stashed=0
    if ! git diff --quiet HEAD 2>/dev/null; then
        git stash push -u && stashed=1
    fi
    git pull -r
    if [ "$stashed" -eq 1 ]; then
        git stash pop || log_error "$dir: stash pop 有冲突，请手动处理"
    fi
    cd - >/dev/null
}
