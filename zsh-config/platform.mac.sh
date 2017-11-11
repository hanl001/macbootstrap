### -------- aliases ------------ ###
alias la='ls -a'
alias pin='pod install'
alias gs='git status'
alias ga='git add '
alias gcm='git commit -m '
alias gl='git pull'
alias gp='git push'
alias gb='git branch'
alias gco='git checkout'
alias soundoff='sudo nvram SystemAudioVolume=%80'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
#alias autoPackage='curl -s -u hanl:hanl -X POST "HTTP://127.0.0.1:8080/job/JFBackHome/build?token=123456"'
alias o='open'
alias oo='open .'
alias ll='ls -alhG'
alias ip="ifconfig | sed -n -e '/127.0.0.1/d' -e '/inet /p'|awk '{print \$2}'"

# Follow this page to avoid enter password
# http://apple.stackexchange.com/questions/236806/prevent-networksetup-from-asking-for-password
function proxy() {
    network=$(networksetup -listallnetworkservices | row 3)
    case "$1" in
    on)
        sudo networksetup -setwebproxystate $network on;
        sudo networksetup -setsecurewebproxystate $network on;
        sudo networksetup -setwebproxy $network 127.0.0.1 8888;
        sudo networksetup -setsecurewebproxy $network 127.0.0.1 8888;
        sudo networksetup -setautoproxystate $network off;
        sudo networksetup -setsocksfirewallproxystate $network off;
        ;;
    g)
        sudo networksetup -setwebproxystate $network off;
        sudo networksetup -setsecurewebproxystate  $network off;
        sudo networksetup -setautoproxystate $network off;
        sudo networksetup -setsocksfirewallproxy "$network" localhost 14179
        ;;
    off)
        sudo networksetup -setwebproxystate $network off;
        sudo networksetup -setsecurewebproxystate  $network off;
        sudo networksetup -setautoproxystate $network off;
        sudo networksetup -setsocksfirewallproxystate $network off;
        ;;
    s)
        socks_status=$(networksetup -getsocksfirewallproxy $network | head -n 3;)
        socks_enable=$(echo $socks_status | head -n 1 | awk '{print $2}')
        socks_ip=$(echo $socks_status | head -n 2 | tail -n 1 | awk '{print $2}')
        socks_port=$(echo $socks_status | tail -n 1 | awk '{print $2}')

        if [ "$socks_enable" = "Yes" ]; then
            echo -e "${green}Socks: ✔${NC}" $socks_ip ":" $socks_port
        else
            echo -e "${RED}Socks: ✘${NC}" $socks_ip ":" $socks_port
        fi

        http_status=$(networksetup -getwebproxy $network | head -n 3)
        http_enable=$(echo $http_status | head -n 1 | awk '{print $2}')
        http_ip=$(echo $http_status | head -n 2 | tail -n 1 | awk '{print $2}')
        http_port=$(echo $http_status | tail -n 1 | awk '{print $2}')

        if [ "$http_enable" = "Yes" ]; then
            echo -e "${green}HTTP : ✔${NC}" $http_ip ":" $http_port
        else
            echo -e "${RED}HTTP : ✘${NC}" $http_ip ":" $http_port
        fi

        https_status=$(networksetup -getsecurewebproxy $network | head -n 3)
        https_enable=$(echo $https_status | head -n 1 | awk '{print $2}')
        https_ip=$(echo $https_status | head -n 2 | tail -n 1 | awk '{print $2}')
        https_port=$(echo $https_status | tail -n 1 | awk '{print $2}')

        if [ "$https_enable" = "Yes" ]; then
            echo -e "${green}HTTPS: ✔${NC}" $https_ip ":" $https_port
        else
            echo -e "${RED}HTTPS: ✘${NC}" $https_ip ":" $https_port
        fi
        ;;
    *)
        echo "Usage: p {on|off|g|s}"
        echo "p on : Set proxy to Charles(port 8888)"
        echo "p off: Reset proxy to system default"
        echo "p g  : Set proxy to GoAgentx(port 14179)"
        echo "p s  : Show current network proxy status"
        echo "p *  : Show usage"
        ;;
    esac
}

alias p=proxy

function ow() {
    if [[ -n "$@" ]]; then
        (cd "$@" && ow)
    else
        if ls *.xcodeproj 2>&1 1>/dev/null; then
            for i in *.xcodeproj;open "$i"
        else
            echo "ERROR, xcode project not exists in '$(pwd)' !"
            echo "Use this in xcode project directory or use 'ow <DIRECTORY>'"
        fi
    fi
}

#如果不指定文件名，默认是当前目录下递归搜索，否则在指定文件名中搜索
function bsgrep() {
    if [ $# -eq 1 ]; then
        grep -rna "$1" .
    else
        grep -na "$1" "$pwd/$2"
    fi
}

function hs(){
   emulate -L zsh
   local message=$1
   history | grep --color=always -i "$message" | awk '{$1="";print $0}' |
   sort | uniq -c | sort -rn | awk '{$1="";print NR " " $0}' |
   tee ~/.histfile_color_result | gsed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" |
   awk '{$1="";print "function " NR "() {" $0 "; echo \": $(date +%s):0;"$0"\" >> ~/.histfile }"}' | 
   {while read line; do eval $line &>/dev/null; done}
   cat ~/.histfile_color_result | sed '1!G;h;$!d' 
}

function pt() {
    launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.polipo.plist
    export http_proxy=http://localhost:8123
    export https_proxy=http://localhost:8123
}

mtdir () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}


### -------- tools add ----------- ###

##new blog

function newblog() {
	emulate -L zsh
	local blog_name=$1
	sudo hexo new $blog_name
	cd ~/Hexo/source/_posts
	sudo chmod 777 $blog_name.md
	open $blog_name.md
}

##pyenv python版本管理工具
#export PYENV_ROOT=/usr/local/var/pyenv
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

##nvm node管理工具
##rnvm() {
##export NVM_DIR="$HOME/.nvm"
##. "$(brew --prefix nvm)/nvm.sh"
##}
