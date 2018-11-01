
if [ ! -z ${P4ENABLED+x} ]; then
	if type p4 > /dev/null 2>&1; then
		[ ! -z ${P4PORT} ] && export P4PORT
		[ ! -z ${P4USER} ] && export P4USER
		[ ! -z ${P4PASSWD} ] && export P4PASSWD
		[ ! -z ${P4CLIENT} ] && export P4CLIENT
	fi
fi

