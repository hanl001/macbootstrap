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

if [[ ! -e /usr/local/bin/fzf ]]; then
    brew install fzf
else
    echo "You have installed fzf"
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

if [[ ! -e /usr/local/bin/gsed ]]; then
    brew install gnu-sed
else
    echo "You have installed gsed"
fi

if [[ ! -e /usr/bin/ctags ]]; then
    brew install ctags --HEAD
else
    echo "You have installed ctags"
fi

if [[ ! -e /usr/local/bin/pod ]]; then
    sudo gem install cocoapods
else
    echo "You have installed cocoapods"
fi
if [[ ! -e /usr/local/bin/fastlane ]]; then
    sudo gem install colored
    sudo gem install -n /usr/local/bin fastlane
else
    echo "You have installed fastlane"
fi


if [[ ! -e ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "You have downloaded oh my zsh"
fi

if [[ ! -e ~/Library/Developer/Xcode/UserData/CodeSnippets ]]; then
    git clone https://github.com/hanl001/CodeSnippets.git ~/Library/Developer/Xcode/UserData/CodeSnippets
else
    echo "You have cloned xcode code snippets"
fi

if [[ ! -e ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    git clone git@github.com:zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "You have cloned zsh autosuggestions"
fi

if [[ ! -e ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "You have cloned zsh syntax highlighting"
fi

