function exe_cmd() {
    log_run "$1"
    eval $1
}

# 安全建软链，替代裸 ln -sf：
#   - 已是指向 src 的正确软链 → 跳过（幂等、安静）
#   - 目标是真实文件/目录 → 先备份成 .bak.<时间戳> 再替换，绝不静默覆盖用户数据
#   - 用 -sfn：目标若是已存在的目录软链，替换它本身而非把链建进其内部
function _link() {
    local src="$1" dst="$2"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        log_info "已链接，跳过: $dst -> $src"
        return 0
    fi
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        local bak="$dst.bak.`date +%Y%m%d%H%M%S`"
        log_todo "$dst 是真实文件，备份到 $bak 再替换"
        mv "$dst" "$bak"
    fi
    exe_cmd "ln -sfn '$src' '$dst'"
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
