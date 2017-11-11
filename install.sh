#!/bin/sh

if [[ ! -e /usr/local/bin/brew ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo “You have installed brew”
fi

if [[ ! -e /Applications/iTerm.app ]]; then
    brew cask install iterm2
else
    echo “You have installed iTerm2”
fi

if [[ ! -e /Applications/SourceTree.app/ ]]; then
    brew cask install sourcetree
else
    echo “You have installed SourceTree”
fi

if [[ ! -e /usr/local/bin/wget ]]; then
    brew install wget
else
    echo “You have installed wget”
fi

if [[ ! -e /usr/local/bin/cmake ]]; then
    brew install cmake
else
    echo "You have installed cmake"
fi

if [[ ! -e /usr/local/bin/autojump ]]; then
    brew install autojump
else
    echo "You have installed autojump"
fi

if [[ ! -e /usr/local/bin/node ]]; then
    brew install node
else
    echo "You have installed node"
fi

if [[ ! -e /usr/bin/ctags ]]; then
    brew install ctags --HEAD
else
    echo "You have installed ctags"
fi

##if [[ ! -e /usr/bin/ctags ]]; then
##    brew install thefuck
##else
##    echo "You have installed the fuck"
##fi

# link git config
mv ~/.gitconfig ~/.gitconfig_backup
ln -s ~/.macbootstrap/git-config/.gitconfig ~/.gitconfig

if [[ ! -e ~/.oh-my-zsh ]]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# link shell config
mv ~/.zshrc ~/.zshrc_backup
ln -s ~/.macbootstrap/sh-config/.zshrc ~/.zshrc

mv ~/.bashrc ~/.bashrc_backup
ln -s ~/.macbootstrap/sh-config/.bashrc ~/.bashrc

mv ~/.bash_profile  ~/.bash_profile_backup
ln -s ~/.macbootstrap/sh-config/.bash_profile ~/.bash_profile

# Gem update
sudo gem update --system
sudo gem install -n /usr/local/bin cocoapods
sudo gem install colored
