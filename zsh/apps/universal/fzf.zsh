
if type fzf > /dev/null 2>&1; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    # herdr in tmux 対策
    if [[ -z $HERDR_ENV && -n $TMUX ]] && kill -0 ${${TMUX#*,}%%,*} 2> /dev/null; then
        export FZF_TMUX=1
        export FZF_TMUX_OPTS="-p 80%"
    else
        unset FZF_TMUX FZF_TMUX_OPTS
    fi

    # pane 内に浮かせて表示する。
    export FZF_DEFAULT_OPTS="--height=80% --margin=5% --border=rounded --layout=reverse"
fi

