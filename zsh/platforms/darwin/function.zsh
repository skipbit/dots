
if type peco >/dev/null 2>&1; then
    function peco-history-selection() {
        BUFFER=$(fc -l -n 1 | tail -10000 | sort | uniq | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }
    zle -N peco-history-selection
    bindkey '^X^R' peco-history-selection
fi

if ! type realpath >/dev/null  2>&1; then
    function realpath() {
        python -c 'import os, sys; print(os.path.realpath(sys.argv[1]))' $@
    }
fi
