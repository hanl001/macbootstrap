### -------- aliases ------------ ###
alias pin='pod install'
alias pud='pod update'
alias soundoff='sudo nvram SystemAudioVolume=%80'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias o='open'
alias la='ls -a'
alias ip="ifconfig | sed -n -e '/127.0.0.1/d' -e '/inet /p'|awk '{print \$2}'"
alias os='open *.xcworkspace'
alias oj='open *.xcodeproj'
alias vs='open /System/Volumes/Data/Applications/Visual\ Studio\ Code.app'
alias ph='open /System/Volumes/Data/Applications/PhpStorm.app'

### -------- function ------------ ###

function exe_cmd() {
	echo $1
	eval $1
}

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

function hs() {
   emulate -L zsh
   local message=$1
   history | grep --color=always -i "$message" | awk '{$1="";print $0}' |
   sort | uniq -c | sort -rn | awk '{$1="";print NR " " $0}' |
   tee ~/.histfile_color_result | gsed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" |
   awk '{$1="";print "function " NR "() {" $0 "; echo \": $(date +%s):0;"$0"\" >> ~/.histfile }"}' | 
   {while read line; do eval $line &>/dev/null; done}
   cat ~/.histfile_color_result | sed '1!G;h;$!d' 
}

function btc() {
    curl -s 'https://blockchain.info/ticker' | grep 'USD\|CNY'
}
