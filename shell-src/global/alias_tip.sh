# 及时 alias 提醒：当你敲的命令其实已有 alias 时，在执行前弹一行 tip。
# 靠 zsh 的 preexec 钩子实现——$1 是「按下回车时的原始命令行」（尚未做 alias 展开），
# 所以你直接敲 alias 本身不会触发，只有敲了它的展开式才提醒。
autoload -Uz add-zsh-hook

_alias_tip() {
    emulate -L zsh
    local typed=$1
    local name val best_name="" best_val=""
    # 遍历当前所有 alias，挑「展开式能匹配命令前缀」里最长（最贴切）的那个
    for name val in ${(kv)aliases}; do
        [[ -z $val ]] && continue
        if [[ $typed == $val || $typed == "$val "* ]]; then
            if (( ${#val} > ${#best_val} )); then
                best_val=$val
                best_name=$name
            fi
        fi
    done
    [[ -n $best_name ]] && print -P "%F{yellow}💡 有 alias：%f%F{green}${best_name}%f → ${best_val}"
    return 0
}

add-zsh-hook preexec _alias_tip
