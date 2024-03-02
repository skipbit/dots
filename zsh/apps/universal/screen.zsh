
if type screen > /dev/null 2>&1; then
    # セッションの保存先 (恒久的に保存するため)
    SCREENDIR=$HOME/.screens
    if [ ! -d "${SCREENDIR}" ]; then
        mkdir "${SCREENDIR}"
        chmod 700 "${SCREENDIR}"
    fi
    export SCREENDIR

    # ステータスバーの表示
    case "$TERM" in
    screen)
        preexec() {
            # echo -ne "\ek#${1%% *}\e\\"
            echo -ne "\ek$1\e\\"
        }
        precmd() {
            echo -ne "\ek$(basename $(pwd))\e\\"
            # echo -ne "\ek$(basename $SHELL)\e\\"
        }
    esac
fi

