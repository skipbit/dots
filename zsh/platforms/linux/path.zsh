
# it's too old that ubuntu's fzf from apt.
# please install from https://github.com/junegunn/fzf instead of apt
if [ -e "${HOME}/.fzf" ]; then
    path=("${HOME}/.fzf/bin" $path)
    fpath=("${HOME}/.fzf/shell" $fpath)
fi

# Homebrew
path=("${HOME}/.homebrew/bin"(N-/) "${HOME}/.homebrew/sbin"(N-/) $path)
if type brew > /dev/null 2>&1; then
    fpath=("$(brew --prefix)/share/zsh/site-functions"(N-/) $fpath)
fi
