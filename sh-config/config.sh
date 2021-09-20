[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin"

## flutter env
export PATH="$PATH:$HOME/flutter/bin"

## arc env
export PATH="$PATH:$HOME/phabricator/arcanist/bin"

## cargo env
export PATH="$HOME/.cargo/bin:$PATH"

## java home
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"

##autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# key binder
bindkey '^p' autosuggest-accept
