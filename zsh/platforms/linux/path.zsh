
# it's too old that ubuntu's fzf from apt.
# please install from https://github.com/junegunn/fzf instead of apt
if [ -e "${HOME}/.fzf" ]; then
    path=("${HOME}/.fzf/bin" $path)
    fpath=("${HOME}/.fzf/shell" $fpath)
fi
