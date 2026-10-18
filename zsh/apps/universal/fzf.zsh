
if type fzf > /dev/null 2>&1; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    # herdr in tmux 対策
    if [[ -z $HERDR_ENV && -n $TMUX ]] && kill -0 ${${TMUX#*,}%%,*} 2> /dev/null; then
        export FZF_TMUX=1
        export FZF_TMUX_OPTS="-p 80%"
    else
        unset FZF_TMUX FZF_TMUX_OPTS
    fi

    # herdr 内は fzf-herdr のポップアップに出す。fzf の連携より後に読む。
    _fzf_herdr=${XDG_DATA_HOME:-$HOME/.local/share}/fzf-herdr/shell/fzf-herdr.zsh
    [[ -r $_fzf_herdr ]] && source $_fzf_herdr
    unset _fzf_herdr
    export FZF_HERDR_WIDTH=80% FZF_HERDR_HEIGHT=80%

    # pane 内に浮かせて表示する。
    export FZF_DEFAULT_OPTS="--height=80% --margin=5% --border=rounded --layout=reverse"
fi

