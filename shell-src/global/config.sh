[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin"

# flutter env
export PATH="$PATH:$MACBOOTSTRAP_ROOT/command/flutter/bin"

# arc env
export PATH="$PATH:$MACBOOTSTRAP_ROOT/command/phabricator/arcanist/bin"

# cargo env
export PATH="$PATH:$HOME/.cargo/bin"

# java home
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# fzf
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# php
export PATH="$PATH:/opt/homebrew/opt/php@7.4/bin"
export PATH="$PATH:/opt/homebrew/opt/php@7.4/sbin"

# ruby
export PATH="$PATH:/opt/homebrew/opt/ruby/bin"

# umi
export PATH="$PATH:`yarn global bin`"

# key binder
bindkey '^p' autosuggest-accept

SKETCH=$(mdfind kMDItemCFBundleIdentifier=='com.bohemiancoding.sketch3' | head -n 1)
export PATH="$PATH:/Applications/Sketch.app/Contents/Resources/sketchtool/bin"

eval "$(rbenv init - zsh)"

export PATH="$PATH:/Users/hanling/.mint/bin"

# APPAnalyzeCommand
export PATH="$PATH:$MACBOOTSTRAP_ROOT/command/APPAnalyzeCommand"

#https://github.com/aria2/aria2/issues/2083#issuecomment-1688886650
export LC_MESSAGES="C"

export OHPM_HOME=/Users/hanling/git/command-line-tools/ohpm
export PATH=${OHPM_HOME}/bin:${PATH}

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
