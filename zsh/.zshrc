# .zsh/.zshrc
#! シェルを起動するたびに読み込まれる. 対話的に使うのに必要な設定を書く.
#! scp や emacs:M-! 等では zshenv のみ、のはず ?

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

type specload > /dev/null 2>&1 || source "${ZDOTDIR}/core/init.zsh"

zspecload alias
#zspecload option
zspecload color
zspecload compctl
zspecload function
zspecload module

_resources=(screen fzf)
for _rc in "${_resources[@]}"; do
	_conf="${ZDOTDIR}/apps/universal/${_rc}.zsh"
	if [ -f "${_conf}" ]; then
		type "${_rc}" > /dev/null 2>&1 && source "${_conf}"
	fi
done

