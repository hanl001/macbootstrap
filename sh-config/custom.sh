### -------- aliases ------------ ###
alias pin='pod install'
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gl='git pull'
alias gp='git push'
alias gb='git branch'
alias gco='git checkout'
alias soundoff='sudo nvram SystemAudioVolume=%80'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
#alias autoPackage='curl -s -u hanl:hanl -X POST "HTTP://127.0.0.1:8080/job/JFBackHome/build?token=123456"'
alias o='open'
alias oo='open .'
alias la='ls -a'
alias ip="ifconfig | sed -n -e '/127.0.0.1/d' -e '/inet /p'|awk '{print \$2}'"

### -------- function ------------ ###
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

mtdir () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

##new blog
function newblog() {
	emulate -L zsh
	local blog_name=$1
	sudo hexo new $blog_name
	cd ~/Hexo/source/_posts
	sudo chmod 777 $blog_name.md
	open $blog_name.md
}
