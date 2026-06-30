function update() {
    _pull_rebase_safely "$MACBOOTSTRAP_ROOT"
    _pull_rebase_safely ~/.oh-my-zsh
}
