
# Prevend `path_helper` excution in /etc/zprofile @elcapitan
if [ "$(sw_vers | grep 'ProductVersion' | awk '{ print $2 }' | cut -d . -f -2)" = "10.11" ]; then
	setopt no_global_rcs
fi

# Correctly display UTF-8 with combining characters.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    setopt combiningchars
fi

