
# Terminal Color
# - usage: % tc <color name> 'text'
# - example: echo "$(tc RED '[error]') This is error message."
# - seealso: <http://qiita.com/tkhren/items/d86b8ae6c1a67da0aa67>
function tc() {
	local output=
	local i=0 c= e=
	local colors=(black red green yellow blue magenta cyan white \
				  BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE) # bold

	[[ $1 = "-e" ]] && e=1 && shift

	for c in ${colors[@]}; do
		if [[ $1 == $c ]]; then
			[[ $i -gt 7 ]] && output+="\[$(tput bold)\]"
			output+="\[$(tput setaf $((i % 8)))\]"
			shift
			break
		fi
		((i++))
	done

	if [[ ( $# -ne 0 ) || ( $i -eq ${#colors[@]} ) ]]; then
		output+="$@\[$(tput sgr0)\]"
	fi
	if [[ -z $e ]]; then
		output="$(echo "$output" | sed -E '/s\\\[|\\\]//g')"
		echo -n "$output"
	fi
}

function include() {
	if [[ -f $1 ]]; then
		source "$1"
	else
		echo "The file '$1' is not found" 1>&2
		return 1
	fi
}

function settitle() {
	local title="${1}"
	case "${TERM}" in
		xterm*|kterm*|rxvt*)
			echo -ne "\033]0;${title}\007"
		;;
		screen*)
			echo -ne "\033P\033]0;${title}\007\033\\"
		;;
	esac
}

function chkinstall() {
	local cmd="${1}"
	which "${cmd}" > /dev/null 2>&1 ; [ $? -eq 0 ] && echo "OK" || echo "NG"
}

function lowercase() {
	local str="${1}"
	if [ ! -z "${str}" ]; then
		echo "${str}" | tr '[:upper:]' '[:lower:]'
	fi
}

function uppercase() {
	local str="${1}"
	if [ ! -z "${str}" ]; then
		echo "${str}" | tr '[:lower:]' '[:upper:]'
	fi
}

function numericversion() {
	local verstring="${1}"
	echo "${verstring}" | (IFS=. read -r major minor micro; printf "%2d%02d%02d" ${major:-0} ${minor:-0} ${micro:-0})
}

# <http://qiita.com/kawaz/items/2b6ef25f63a4f5300e84>
function tmpspace() {
	local d=$(mktemp -d "${TMPDIR:-/tmp}/${1:-tmpspace}.XXXXXXXXXX") && pushd "${d}" >/dev/null 2>&1 || return 1
	"${SHELL}"
	s=$?
	if [[ $s == 0 ]]; then
		rm -rf "${d}"
	else
		echo "Directory '${d}' still exists." >&2
	fi
	popd >/dev/null 2>&1
	return $s
}

