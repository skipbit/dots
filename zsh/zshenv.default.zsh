# ~/.zshenv (.zsh/zshenv.default.zsh)
#! ログイン時に読み込まれる (サブシェル起動時は読まれない). 常に使用する設定を書く.

[[ $PS1 != "" && $TTY != "" ]] && echo "[31m*****  Loading $HOME/.zshenv[m" > $TTY

# initialize universal environment settings.
export ZDOTDIR=$HOME/.zsh


# initialize universal path setting
#! -U: path の重複を登録しない.
typeset -U path
path=($path /usr/libexec /usr/local/libexec)

typeset -U manpath cdpath fpath

#! -x: export SUDO_PATH も同時に行う.
#! -T: SUDO_PATH と sudo_path を連動する.
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/local,/usr}/sbin(N-/))

#
typeset -UxT PKG_CONFIG_PATH pkg_config_path
pkg_config_path=(/usr/lib/pkgconfig(N-/) /usr/local/lib/pkgconfig(N-/))

# initialize platforms and host specified environment settings.
if [ -f ${ZDOTDIR}/core/init.zsh ]; then
	source ${ZDOTDIR}/core/init.zsh
	zspecload path
	zspecload env

	zspecload option
fi

