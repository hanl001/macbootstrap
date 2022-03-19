function tm() {
    _to_project_path
}

function txs() {
    _to_xcode_snippets_path
}

function _to_project_path() {
    exe_cmd "cd $project_path"
}

function _to_xcode_snippets_path() {
    exe_cmd "cd ~/Library/Developer/Xcode/UserData/CodeSnippets"
}
