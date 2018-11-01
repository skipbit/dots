
# Language & Locale
export LANG="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"
export LANGUAGE=$LANG

# Editor
export EDITOR="vi"

# Pager
type lv > /dev/null 2>&1 && export PAGER="lv" || export PAGER="less"


# Configure universal applications
_programs=(less lv git)
for _appName in "${_programs[@]}"; do
	_appConfig="${ZDOTDIR}/apps/universal/${_appName}.zsh"
	if [ -f "${_appConfig}" ]; then
		type ${_appName} > /dev/null 2>&1 && source "${_appConfig}"
	fi
done

