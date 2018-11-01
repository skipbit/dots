
export GIT_EDITOR="${EDITOR}"
[ "${PAGER}" = "lv" ] && export GIT_PAGER="lv -c" || export GIT_PAGER="less -q -R"

