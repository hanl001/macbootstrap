function link() {
    exe_cmd "link_git"
    exe_cmd "link_shell"
    exe_cmd "link_ranger"
    exe_cmd "link_vim"
    exe_cmd "link_lldb"
}

function link_git() {
    gitignore_source_path="$config_path/git-config/_gitconfig"
    gitignore_target_path="$config_path/git-config/.gitconfig"

    if [[ ! -e $gitignore_target_path ]]; then
        exe_cmd "cp $gitignore_source_path $gitignore_target_path"
    fi

    exe_cmd "ln -sf $gitignore_target_path ~/.gitconfig"
    exe_cmd "ln -sf $config_path/git-config/_gitignore_global ~/.gitignore_global"
}

function link_shell() {
    exe_cmd "ln -sf $config_path/sh-config/_zshrc ~/.zshrc"
    exe_cmd "ln -sf $config_path/sh-config/_zprofile ~/.zprofile"
    exe_cmd "ln -sf $config_path/sh-config/_zshenv ~/.zshenv"

    exe_cmd "ln -sf $config_path/sh-config/_inputrc ~/.inputrc"

    exe_cmd "ln -sf $config_path/sh-config/_bashrc ~/.bashrc"
    exe_cmd "ln -sf $config_path/sh-config/_bash_profile ~/.bash_profile"
}

function link_ranger() {
    exe_cmd "mkdir -p ~/.config/ranger"
    exe_cmd "ln -sf $config_path/tool-config/ranger/commands.py ~/.config/ranger/commands.py"
    exe_cmd "ln -sf $config_path/tool-config/ranger/commands_full.py ~/.config/ranger/commands_full.py"
    exe_cmd "ln -sf $config_path/tool-config/ranger/rc.conf ~/.config/ranger/rc.conf"
    exe_cmd "ln -sf $config_path/tool-config/ranger/rifle.conf ~/.config/ranger/rifle.conf"
    exe_cmd "ln -sf $config_path/tool-config/ranger/scope.sh ~/.config/ranger/scope.sh"
}

function link_vim() {
    exe_cmd "ln -sf $config_path/vim-config/vimfiles ~/.vim"
    exe_cmd "ln -sf $config_path/vim-config/_vimrc ~/.vimrc"
    exe_cmd "ln -sf $config_path/vim-config/nvim/init.vim ~/.config/nvim/init.vim"

    if [ ! -d "$config_path/vim-config/vimfiles/bundle/Vundle.vim" ]; then
        exe_cmd "git clone https://github.com/VundleVim/Vundle.vim.git $config_path/vim-config/vimfiles/bundle/Vundle.vim"
        exe_cmd 'vim +PluginInstall +qall'
    fi
}

function link_lldb() {
    exe_cmd "ln -sf $config_path/tool-config/lldb/_lldbinit ~/.lldbinit"
}
