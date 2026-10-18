# .zsh/.zshrc
#! 対話シェルの起動時に読み込まれる. 対話的に使うのに必要な設定を書く.
#! スクリプトや ssh 先でのコマンド実行など、非対話のシェルでは読まれない.

[[ $PS1 != "" && $TTY != "" ]] && echo "[31m*****  Loading $ZDOTDIR/.zshrc[m" > $TTY

HISTSIZE=1048576
SAVEHIST=1048576
HISTFILE=$ZDOTDIR/.zhistory

WATCH=notme

PROMPT="[%n@%m%u]%# "
RPROMPT="[%~]"
if [ $UID = 0 ]; then
        PROMPT="[%n@%m%u]%# "
        RPROMPT="[%~]"
fi

WORDCHARS=''

# stty
if [[ "$OSTYPE" =~ "darwin" ]]; then
	stty discard undef
fi

# keyboard binding
bindkey -e

bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^w' kill-word
bindkey '^h' backward-kill-word

# 単語ごと削除
#bindkey '^[h' backward-kill-word       # ^W が標準

type zspecload > /dev/null 2>&1 || source "${ZDOTDIR}/core/init.zsh"

zspecload option
zspecload alias
zspecload color
zspecload compctl
zspecload function
zspecload module

for _rc in $(ls ${ZDOTDIR}/apps/universal/*.zsh); do
    source "${_rc}"
done

