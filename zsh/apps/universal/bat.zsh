
if type bat > /dev/null 2>&1; then
    export BAT_THEME="Dracula"
    export BAT_PAGER="less -RF"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

