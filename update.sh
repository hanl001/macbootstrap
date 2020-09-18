cd ~/.macbootstrap
git stash
git pull -r
git stash pop
cd -
cd ~/.oh-my-zsh
git stash
upgrade_oh_my_zsh
git stash pop
cd -

