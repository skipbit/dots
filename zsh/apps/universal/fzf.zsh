
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

    # pane 内に浮かせて表示する。入力欄の位置は fzf の既定に任せる
    # (CTRL-T、ALT-C、補完は上、履歴と直接の呼び出しは下)。
    export FZF_DEFAULT_OPTS="--height=80% --margin=5% --border=rounded"

    # ALT-C では選んでいるディレクトリの一覧を見る。
    export FZF_ALT_C_OPTS="--preview 'ls -Ap {}'"

    # CTRL-T と補完 (**<TAB>) では、選んでいるファイルの中身を、ディレクトリなら一覧を見る。
    # 補完はホスト名や変数名も同じ経路で選ぶので、それ以外のときは何も出さない。
    # Ubuntu の apt では bat が batcat という名前で入る。
    _fzf_bat=${commands[bat]:-$commands[batcat]}
    if [[ -n $_fzf_bat ]]; then
        export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then ls -Ap {}; elif [ -f {} ]; then $_fzf_bat -n --color=always {}; fi'"
        export FZF_COMPLETION_OPTS=$FZF_CTRL_T_OPTS
    fi
    unset _fzf_bat
fi

