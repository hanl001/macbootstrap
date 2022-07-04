function install() {
    exe_cmd "check_brew"
    exe_cmd "check_oh_myzsh"
    exe_cmd "check_vim"
    exe_cmd "check_xcode_snippets"
    exe_cmd "check_applications"
}

function check_brew() {
    if [[ ! -e /opt/homebrew/bin/brew ]]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if [[ $(uname -m) == 'arm64' ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "You have installed brew"
    fi
    
    if [[ ! -e /opt/homebrew/bin/wget ]]; then
        brew install wget
    else
        echo "You have installed wget"
    fi
    
    if [[ ! -e /opt/homebrew/bin/fzf ]]; then
        brew install fzf
    else
        echo "You have installed fzf"
    fi
    
    if [[ ! -e /opt/homebrew/bin/tig ]]; then
        brew install tig
    else
        echo "You have installed tig"
    fi
    
    if [[ ! -e /opt/homebrew/bin/htop ]]; then
        brew install htop
    else
        echo "You have installed htop"
    fi
    
    if [[ ! -e /opt/homebrew/bin/cmake ]]; then
        brew install cmake
    else
        echo "You have installed cmake"
    fi
    
    if [[ ! -e /opt/homebrew/bin/autojump ]]; then
        brew install autojump
    else
        echo "You have installed autojump"
    fi
    
    if [[ ! -e /opt/homebrew/bin/node ]]; then
        brew install node
    else
        echo "You have installed node"
    fi
    
    if [[ ! -e /opt/homebrew/bin/gsed ]]; then
        brew install gnu-sed
    else
        echo "You have installed gsed"
    fi
    
    if [[ ! -e /opt/homebrew/bin/ctags ]]; then
        brew install ctags --HEAD
    else
        echo "You have installed ctags"
    fi
    
    if [[ ! -e /opt/homebrew/bin/ranger ]]; then
        brew install ranger
    else
        echo "You have installed ranger"
    fi
    
    if [[ ! -e /opt/homebrew/bin/pod ]]; then
        brew install cocoapods
    else
        echo "You have installed cocoapods"
    fi
    
    if [[ ! -e /opt/homebrew/bin/fastlane ]]; then
        brew install fastlane
    else
        echo "You have installed fastlane"
    fi
    
    if [[ ! -e /opt/homebrew/bin/imgcat ]]; then
        brew install danielgatis/imgcat/imgcat
    else
        echo "You have installed imgcat"
    fi
    
    if brew ls --versions chisel > /dev/null; then
        echo "You have installed chisel"
    else
        brew install chisel
    fi
    
    if brew ls --versions aria2 > /dev/null; then
        echo "You have installed aria2"
    else
        brew install aria2
    fi
    
    if brew ls --versions php@7.4 > /dev/null; then
        echo "You have installed php@7.4"
    else
        brew install php@7.4
    fi
}

function check_oh_myzsh() {
    if [[ ! -e ~/.oh-my-zsh ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "You have downloaded oh my zsh"
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
}

function check_vim() {
    if [[ ! -e /opt/homebrew/bin/nvim ]]; then
        brew install neovim
    else
        echo "You have installed neovim"
    fi

    if [[ ! -e ~/.config/nvim/pack/github/start/copilot.vim ]]; then
        exe_cmd "git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim"
    else
        echo "You have installed copilot"
    fi
}

function reinstall_xcode_snippets() {
    if [[ ! -e ~/Library/Developer/Xcode/UserData/CodeSnippets ]]; then
        git clone git@github.com:hanl001/CodeSnippets.git ~/Library/Developer/Xcode/UserData/CodeSnippets
    else
        exe_cmd "mv ~/Library/Developer/Xcode/UserData/CodeSnippets ~/Library/Developer/Xcode/UserData/CodeSnippets.bak"
        git clone git@github.com:hanl001/CodeSnippets.git ~/Library/Developer/Xcode/UserData/CodeSnippets
    fi
}

function check_xcode_snippets() {
    if [[ ! -e ~/Library/Developer/Xcode/UserData/CodeSnippets ]]; then
        git clone git@github.com:hanl001/CodeSnippets.git ~/Library/Developer/Xcode/UserData/CodeSnippets
    else
        echo "You have cloned xcode code snippets"
        cd ~/Library/Developer/Xcode/UserData/CodeSnippets
        git add --all
        git stash
        git pull -r
        git stash pop
    fi
}

function check_applications() {
    if [[ ! -e /Applications/SourceTree.app ]]; then
        brew cask install sourcetree
    else
        echo "You have installed SourceTree"
    fi
    
    if [[ ! -e /Applications/WeChat.app ]]; then
        brew cask install wechat
    else
        echo "You have installed WeChat"
    fi
    
    if [[ ! -e /Applications/Google\ Chrome.app ]]; then
        brew cask install google-chrome
    
        # Set Chrome as default browser
        git clone https://github.com/kerma/defaultbrowser ./temp/defaultbrowser
        (cd ./temp/defaultbrowser && make && make install)
        defaultbrowser chrome
        [[ -d ./temp/defaultbrowser ]] && rm -rf ./temp/defaultbrowser
    else
        echo "You have installed chrome"
    fi
    
    if [[ ! -e /Applications/Visual\ Studio\ Code.app ]]; then
        brew cask install visual-studio-code
    else
        echo "You have installed vscode"
    fi
}
