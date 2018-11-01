
function zspecload() {
	local NAME="$1"

	local CORE=${ZDOTDIR}/core/${NAME}.zsh
	if [ -f ${CORE} ]; then
		source ${CORE}
		[[ $PS1 != "" && $TTY != "" ]] && echo "[33m*****  Loading ${CORE}[m" > $TTY
	fi
	
	local OSSPEC=${ZDOTDIR}/platforms/`uname | tr '[:upper:]' '[:lower:]'`/${NAME}.zsh
	if [ -f ${OSSPEC} ]; then
		source ${OSSPEC}
		[[ $PS1 != "" && $TTY != "" ]] && echo "[32m*****  Loading ${OSSPEC}[m" > $TTY
	fi

	local HOSTSPEC=${ZDOTDIR}/hosts/`hostname -s`/${NAME}.zsh
	if [ -f ${HOSTSPEC} ]; then
		source ${HOSTSPEC}
		[[ $PS1 != "" && $TTY != "" ]] && echo "[34m*****  Loading ${HOSTSPEC}[m" > $TTY
	fi
}

function zappload() {
	local name="${1}"
	if [ ! -z ${name} ]; then
        local folders=(core "$(uname | tr '[:upper:]' '[:lower:]')" "$(hostname -s)")
		for folder in "${folders[@]}"; do
            if [ -d "${ZDOTDIR}/apps/${folder}" ]; then
    			source "${ZDOTDIR}/apps/${folder}/${name}.zsh"
            fi
		done
	fi
}

