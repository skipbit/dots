
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git
function gitpath()
{
    git rev-parse --show-superproject-working-tree --show-toplevel | head -1

#    p="$(git rev-parse --git-dir)"
#    if [ "${p}" = ".git" ]; then
#        # current directory is git-root
#        dirname "$(realpath "${p%%/.git/*}")"
#    elif [ "${p: -5}" = "/.git" ]; then
#        # git repository sub-directory
#        realpath "${p%%/.git*}"
#    else
#        # submodule
#        realpath "${p%%/.git/*}"
#    fi
}
