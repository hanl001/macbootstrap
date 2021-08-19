STRAP_ROOT="$HOME/.macbootstrap"
#!/bin/sh

if [[ ! -e /usr/local/bin/brew ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "You have installed brew"
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

if [[ ! -e /usr/bin/gsed ]]; then
    brew install gnu-sed
else
    echo "You have installed gsed"
fi

if [[ ! -e /usr/bin/ctags ]]; then
    brew install ctags --HEAD
else
    echo "You have installed ctags"
fi

if [[ ! -e ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -e ~/Library/Developer/Xcode/UserData/CodeSnippets ]]; then
    git clone https://github.com/hanl001/CodeSnippets.git ~/Library/Developer/Xcode/UserData/CodeSnippets
fi

# Gem update
sudo gem update --system
sudo gem install -n /usr/local/bin fastlane
sudo gem install cocoapods -v 1.9.3 
sudo gem install colored


