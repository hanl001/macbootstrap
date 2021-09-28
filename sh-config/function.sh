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
    curl -s 'https://blockchain.info/ticker'
}
