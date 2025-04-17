function install() {
    exe_cmd "check_brew"
    exe_cmd "check_oh_myzsh"
    exe_cmd "check_vim"
    exe_cmd "check_xcode_snippets"
    exe_cmd "check_applications"
}

function check_brew() {
    if [[ ! -e /opt/homebrew/bin/brew ]]; then
        /usr/bin/ruby -e "$(curl -fssl https://raw.githubusercontent.com/homebrew/install/master/install)"
        if [[ $(uname -m) == 'arm64' ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $home/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "you have installed brew"
    fi
    
    if [[ ! -e /opt/homebrew/bin/wget ]]; then
        brew install wget
    else
        echo "you have installed wget"
    fi
    
    if [[ ! -e /opt/homebrew/bin/fzf ]]; then
        brew install fzf
    else
        echo "you have installed fzf"
    fi
    
    if [[ ! -e /opt/homebrew/bin/cmake ]]; then
        brew install cmake
    else
        echo "you have installed cmake"
    fi
    
    if [[ ! -e /opt/homebrew/bin/autojump ]]; then
        brew install autojump
    else
        echo "you have installed autojump"
    fi
    
    if [[ ! -e /opt/homebrew/bin/node ]]; then
        brew install node
    else
        echo "you have installed node"
    fi
    
    if [[ ! -e /opt/homebrew/bin/gsed ]]; then
        brew install gnu-sed
    else
        echo "you have installed gsed"
    fi
    
    if [[ ! -e /opt/homebrew/bin/ctags ]]; then
        brew install ctags --head
    else
        echo "you have installed ctags"
    fi
    
    if [[ ! -e /opt/homebrew/bin/ranger ]]; then
        brew install ranger
    else
        echo "you have installed ranger"
    fi
    
    if [[ ! -e /opt/homebrew/bin/pod ]]; then
        brew install cocoapods
    else
        echo "you have installed cocoapods"
    fi
    
    if [[ ! -e /opt/homebrew/bin/fastlane ]]; then
        brew install fastlane
    else
        echo "you have installed fastlane"
    fi
    
    if [[ ! -e /opt/homebrew/bin/imgcat ]]; then
        brew install danielgatis/imgcat/imgcat
    else
        echo "you have installed imgcat"
    fi
    
    if brew ls --versions chisel > /dev/null; then
        echo "you have installed chisel"
    else
        brew install chisel
    fi
    
    if brew ls --versions aria2 > /dev/null; then
        echo "you have installed aria2"
    else
        brew install aria2
    fi
    
    if brew ls --versions php@7.4 > /dev/null; then
        echo "you have installed php@7.4"
    else
        brew install php@7.4
    fi
}

function check_oh_myzsh() {
    if [[ ! -e ~/.oh-my-zsh ]]; then
        sh -c "$(curl -fssl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "you have downloaded oh my zsh"
    fi
    
    if [[ ! -e ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        git clone git@github.com:zsh-users/zsh-autosuggestions.git ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else
        echo "you have cloned zsh autosuggestions"
    fi
    
    if [[ ! -e ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    else
        echo "you have cloned zsh syntax highlighting"
    fi
}

function check_vim() {
    if [[ ! -e /opt/homebrew/bin/nvim ]]; then
        brew install neovim
    else
        echo "you have installed neovim"
    fi

    if [[ ! -e ~/.config/nvim/pack/github/start/copilot.vim ]]; then
        exe_cmd "git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim"
    else
        echo "you have installed copilot"
    fi
}

function reinstall_xcode_snippets() {
    if [[ ! -e ~/library/developer/xcode/userdata/codesnippets ]]; then
        git clone git@github.com:hanl001/codesnippets.git ~/library/developer/xcode/userdata/codesnippets
    else
        exe_cmd "mv ~/library/developer/xcode/userdata/codesnippets ~/library/developer/xcode/userdata/codesnippets.bak"
        git clone git@github.com:hanl001/codesnippets.git ~/library/developer/xcode/userdata/codesnippets
    fi
}

function check_xcode_snippets() {
    if [[ ! -e ~/library/developer/xcode/userdata/codesnippets ]]; then
        git clone git@github.com:hanl001/codesnippets.git ~/library/developer/xcode/userdata/codesnippets
    else
        echo "you have cloned xcode code snippets"
        cd ~/library/developer/xcode/userdata/codesnippets
        git add --all
        git stash
        git pull -r
        git stash pop
    fi
}

function check_applications() {
    if [[ ! -e /applications/sourcetree.app ]]; then
        brew install --cask sourcetree
    else
        echo "you have installed sourcetree"
    fi
    
    if [[ ! -e /applications/wechat.app ]]; then
        brew cask install wechat
    else
        echo "you have installed wechat"
    fi
    
    if [[ ! -e /applications/google\ chrome.app ]]; then
        brew cask install google-chrome
    
        # set chrome as default browser
        git clone https://github.com/kerma/defaultbrowser ./temp/defaultbrowser
        (cd ./temp/defaultbrowser && make && make install)
        defaultbrowser chrome
        [[ -d ./temp/defaultbrowser ]] && rm -rf ./temp/defaultbrowser
    else
        echo "you have installed chrome"
    fi
    
    if [[ ! -e /applications/visual\ studio\ code.app ]]; then
        brew cask install visual-studio-code
    else
        echo "you have installed vscode"
    fi
}
