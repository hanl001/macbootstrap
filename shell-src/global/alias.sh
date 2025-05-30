alias vim='nvim'
alias pud='pod update'
alias pin='pod install'
alias soundoff='sudo nvram SystemAudioVolume=%80'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias o='open'
alias oo='open .'
alias la='ls -a'
alias ip="ifconfig | sed -n -e '/127.0.0.1/d' -e '/inet /p'|awk '{print \$2}'"
alias os='open *.xcworkspace'
alias oj='open *.xcodeproj'
alias vs='open /System/Volumes/Data/Applications/Visual\ Studio\ Code.app'
alias ph='open /System/Volumes/Data/Applications/PhpStorm.app'
alias sf='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hf='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias vf='vim $(fzf --height 40%)'

alias 。。='..'
alias 。='.'
