function update() {
    cd $MACBOOTSTRAP_ROOT
    git stash
    git pull -r
    git stash pop
    cd -
    
    cd ~/.oh-my-zsh
    git stash
    git pull -r
    git stash pop
    cd -
}
