function link() {
    # link git config
    exe_cmd "ln -sf $config_path/git-config/_gitconfig ~/.gitconfig"
    exe_cmd "ln -sf $config_path/git-config/_gitignore_global ~/.gitignore_global"
    
    # link shell config
    exe_cmd "ln -sf $config_path/sh-config/_zshrc ~/.zshrc"
    exe_cmd "ln -sf $config_path/sh-config/_bashrc ~/.bashrc"
    exe_cmd "ln -sf $config_path/sh-config/_bash_profile ~/.bash_profile" 
    exe_cmd "ln -sf $config_path/sh-config/_inputrc ~/.inputrc"
    
    # link ranger config
    exe_cmd "ln -sf $config_path/tool-config/ranger/commands.py ~/.config/ranger/commands.py"
    exe_cmd "ln -sf $config_path/tool-config/ranger/commands_full.py ~/.config/ranger/commands_full.py"
    exe_cmd "ln -sf $config_path/tool-config/ranger/rc.conf ~/.config/ranger/rc.conf"
    exe_cmd "ln -sf $config_path/tool-config/ranger/rifle.conf ~/.config/ranger/rifle.conf"
    exe_cmd "ln -sf $config_path/tool-config/ranger/scope.sh ~/.config/ranger/scope.sh"
    
    # link lldb config
    exe_cmd "ln -sf $config_path/tool-config/lldb/_lldbinit ~/.lldbinit"
}
