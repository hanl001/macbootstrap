function exe_cmd() {
    log_run "$1"
    eval $1
}

function test() {
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
