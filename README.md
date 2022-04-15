# What is this

A shell script to help you set up development environment.

fork from https://github.com/bestswifter/macbootstrap

custom by myself

# How to install

1. First make sure ssh-keygen and xcode command tool

2. Just execute:

```shell
curl https://raw.githubusercontent.com/hanl001/macbootstrap/master/setup.sh | sh
```

# Useful command (see more at: shell-src/global/*.sh)

* `hl`:     some commands to manage this project
* `x`:      zip or unzip anyfile
* `j`:      autojump to anywhere
* `ranger`: finder at iterm
* `pin`:    pod install
* `pud`:    pod update
* `la`:     ls -a
* `o`:      open
* `oo`:     open .
* `os`:     open *.xcworkspace
* `oj`:     open *.xcodeproj
* `vs`:     open /System/Volumes/Data/Applications/Visual\ Studio\ Code.app
* `ph`:     open /System/Volumes/Data/Applications/PhpStorm.app
* `sf`:     show 'hidden file' on finder
* `hf`:     hidden 'hidden file' on finder
* `vf`:     vim fzf find
* `ssh -A`: ssh-agent with local id_rsa

# About git (see more at: _gitconfig)
* `git st`: git status
* `git cm`: git commit -am
* `git co`: git checkout
* `git lg`: beauty git log
* `git dv`: git difftool use vim

# About vim (see more at: config/vim-config/*)
|keys| usage|
|---|---|
|`ctrl + p`        | use fzf search files       |
|`ctrl + n`        | toggle right dir tree      |
|`wm`              | toggle left window         |
|`ctrl + h/j/k/l`  | move at windows            |
|`,r`              | to replace selected words  |
|`,f`              | go to first window         |
|`,sp`             | :set paste                 |
|`,snp`            | `:set nopaste`             |
|`[SPACE]`         | `/`                        |

# About lldb 
* `pjson`: pretty json print
* all command at [chisel](https://github.com/facebook/chisel)

# About ranger (see more at: config/tool-config/ranger/*)
* j: use autojump to anywhere

