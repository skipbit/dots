
if type peco >/dev/null 2>&1; then
    function peco-history-selection() {
        BUFFER=$(fc -l -n 1 | tail -10000 | sort | uniq | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
    }
    zle -N peco-history-selection
    bindkey '^X^R' peco-history-selection
fi

