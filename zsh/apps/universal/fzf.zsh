
if type fzf > /dev/null 2>&1; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    export FZF_TMUX=1
    export FZF_TMUX_OPTS="-p 80%"
fi

