#
# compctl
#

# あらかじめ定義されている補完定義をロード
autoload -U compinit; compinit

# 補完候補にも色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
