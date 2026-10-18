# .zsh/.zprofile
#! ログインシェルで、.zshenv の後に読み込まれる.
#! macOS の /etc/zprofile (path_helper) が並べ替えた PATH を組み立て直す.

[[ $PS1 != "" && $TTY != "" ]] && echo "[31m*****  Loading $ZDOTDIR/.zprofile[m" > $TTY

zspecload path
