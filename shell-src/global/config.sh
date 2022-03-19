[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin"

# flutter env
export PATH="$PATH:$HOME/flutter/bin"

# arc env
export PATH="$PATH:$HOME/phabricator/arcanist/bin"

# cargo env
export PATH="$HOME/.cargo/bin:$PATH"

# java home
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# fzf
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# php
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

# ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# umi
export PATH="$PATH:`yarn global bin`"

# key binder
bindkey '^p' autosuggest-accept
