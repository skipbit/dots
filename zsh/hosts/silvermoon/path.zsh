
# Alternative swift toolchain
path=("/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin"(N-/) $path)

# swiftenv
path=("$HOME/.swiftenv/shims"(N-/) $path "$HOME/.swiftenv/bin"(N-/))
if [ -d "$HOME/.swiftenv" ]; then
	# swiftenv init
	# - command swiftenv rehash 2>/dev/null
	source $HOME/.swiftenv/completions/swiftenv.zsh
fi

# Qt 5.x
if type brew >/dev/null 2>&1; then
	HOMEBREW_PREFIX=$(brew --prefix)
    path=($path "${HOMEBREW_PREFIX}/opt/qt5/bin"(N-/) "${HOMEBREW_PREFIX}/opt/qt55/bin"(N-/) "${HOMEBREW_PREFIX}/opt/qt52/bin"(N-/) "${HOMEBREW_PREFIX}/opt/qt/bin"(N-/))
fi

# ICU
icubase_dir="$(brew --prefix)/opt/icu4c"
if [[ -d "${icubase_dir}" ]]; then
    path=($path "${icubase_dir}/bin"(N-/) "${icubase_dir}/sbin"(N-/))
fi

# Go
if type go >/dev/null 2>&1; then
    export GOROOT=$(go env GOROOT)
    export GOPATH=$HOME/Local/Go
    path=($path "${GOROOT}/bin"(N-/) "${GOPATH}/bin"(N-/))
fi

# git-admiral
path=($path "$HOME/Workspace/Nikon/U1510-gitAdmiral"(N-/))

