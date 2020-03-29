# find file by name
function fn() {
    if [[ "$#" -eq 1 ]]; then
        find . -name "$1"
    elif [[ "$#" -eq 2 ]]; then
        find "$1" -name "$2"
    else
        echo "Useage:fn [DIRECTORY] <pattern>"
    fi
}

# find file by file extension
function fe() {
    if [[ "$#" -eq 1 ]]; then
        find . -name "*.$1"
    elif [[ "$#" -eq 2 ]]; then
        find "$1" -name "*.$2"
    else
        echo "Useage:fe [DIRECTORY] <extension>"
    fi
}

# find & grep by file extension
function xgrep() {
    if [[ "$#" -eq 3 ]]; then
        find "$1" -type f -name "*.$2"|xargs grep -n "$3"
    elif [[ "$#" -eq 2 ]]; then
        find . -type f -name "*.$1"|xargs grep -n "$2"
    else
        echo "Useage:xgrep [DIRECTORY] <file-extension> <pattern>"
    fi
}

# grep file or dir
function cgrep() {
    if [ $# -eq 1 ]; then
        grep -rna "$1" .
    elif [ -d "$2" ]; then
        grep -rna "$1" "$2"
    elif [ -f "$2" ]; then
        grep -na "$1" "$2"
    else
        grep -na "$1" "$pwd/$2"
    fi
}
