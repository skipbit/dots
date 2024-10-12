
alias la="ls -A"
alias l="ls -lh"

alias df="df -h"
alias du="du -sh"

alias grep="grep --color=auto"

# color diff: <http://qiita.com/catatsuy/items/8bafef2a60762a1c9f0f>
if type colordiff > /dev/null 2>&1; then
	alias diff="colordiff -u"
else
	alias diff="diff -u"
fi

