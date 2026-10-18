
# Evaluate path_helper (/etc/zprofile を読まない非ログインのシェルのため)
[ -x /usr/libexec/path_helper ] && eval `/usr/libexec/path_helper -s`

# Developer Tools
if [ -x "/usr/bin/xcode-select" ]; then
	[ -z "${DEVELOPER_DIR}" ] && export DEVELOPER_DIR="`xcode-select -print-path`"
	path=($path "${DEVELOPER_DIR}/usr/bin"(N-/) "${DEVELOPER_DIR}/Tools"(N-/))
	path=($path "${DEVELOPER_DIR:h}/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources"(N-/))
else
	path=($path /Developer/Tools(N-/))
fi

# User-defined
path=($path $HOME/Local/bin(N-/))

# Homebrew
path=(/Library/Homebrew/bin(N-/) $HOME/Library/Homebrew/bin(N-/) $HOME/Local/Homebrew/bin(N-/) $path)
path=(/Library/Homebrew/sbin(N-/) $HOME/Library/Homebrew/sbin(N-/) $HOME/Local/Homebrew/sbin(N-/) $path)
if type brew > /dev/null 2>&1; then
	[ -z "${HOMEBREW_PREFIX}" ] && export HOMEBREW_PREFIX="`brew --prefix`"
	fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions"(N-/) $fpath)
fi

# Linux Tools
path=($path $HOME/.local/bin(N-/))

