STRAP_ROOT="$HOME/.macbootstrap"
#!/bin/sh

if [[ ! -e /usr/local/bin/brew ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "You have installed brew"
fi

if [[ ! -e /Applications/iTerm.app ]]; then
    brew cask install iterm2
else
    echo "You have installed iTerm2"
fi

if [[ ! -e /Applications/SourceTree.app/ ]]; then
    brew cask install sourcetree
else
    echo "You have installed SourceTree"
fi

if [[ ! -e /usr/local/bin/wget ]]; then
    brew install wget
else
    echo "You have installed wget"
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

if [[ ! -e /usr/local/bin/pod ]]; then
    brew install cocoapods
else
    echo "You have installed cocoapods"
fi

if [[ ! -e /usr/local/bin/gsed ]]; then
    brew install gsed
else
    echo "You have installed gsed"
fi

if [[ ! -e /usr/bin/ctags ]]; then
    brew install ctags --HEAD
else
    echo "You have installed ctags"
fi

if [[ ! -e ~/.oh-my-zsh ]]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

if [[ ! -e ~/Library/Developer/Xcode/UserData/CodeSnippets ]]; then
    git clone https://github.com/hanl001/CodeSnippets.git ~/Library/Developer/Xcode/UserData/CodeSnippets
fi

# Gem update
sudo gem update --system
sudo gem install -n /usr/local/bin fastlane
sudo gem install colored


