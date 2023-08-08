
export GIT_EDITOR="${ZDOTDIR}/bin/vix"
[ "${PAGER}" = "lv" ] && export GIT_PAGER="lv -c" || export GIT_PAGER="less -q -R"

