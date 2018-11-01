
# Mac OS X 10.5 Leopard / Xcode 3.1 / Subversion 1.6
if [ "${$(uname):l}" = "darwin" -a "`sw_vers -productVersion | cut -d . -f 1-2`" = "10.5" ]; then
	if type xcodebuild > /dev/null 2>&1 && [ "`xcodebuild -version | awk '/Xcode/ { print $2 }' | cut -d . -f 1-2`" = "3.1" ]; then
		if type svn > /dev/null 2>&1 && [ "`svn --version --quiet`" = "1.6" ]; then
			export DYLD_LIBRARY_PATH="/usr/local/lib"
			export DYLD_FALLBACK_LIBRARY_PATH="/usr/lib"
		fi
	fi
fi

