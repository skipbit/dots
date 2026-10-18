
function zspecload() {
	local NAME="$1"

	local CORE=${ZDOTDIR}/core/${NAME}.zsh
	if [ -f ${CORE} ]; then
		source ${CORE}
		[[ $PS1 != "" && $TTY != "" ]] && echo "[33m*****  Loading ${CORE}[m" > $TTY
	fi
	
	#! OSTYPE (darwin26.0, linux-gnu) から darwin, linux を取り出す.
	local OSSPEC=${ZDOTDIR}/platforms/${OSTYPE%%[0-9-]*}/${NAME}.zsh
	if [ -f ${OSSPEC} ]; then
		source ${OSSPEC}
		[[ $PS1 != "" && $TTY != "" ]] && echo "[32m*****  Loading ${OSSPEC}[m" > $TTY
	fi

	local HOSTSPEC=${ZDOTDIR}/hosts/${HOST%%.*}/${NAME}.zsh
	if [ -f ${HOSTSPEC} ]; then
		source ${HOSTSPEC}
		[[ $PS1 != "" && $TTY != "" ]] && echo "[34m*****  Loading ${HOSTSPEC}[m" > $TTY
	fi
}

