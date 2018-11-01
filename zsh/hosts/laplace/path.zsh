
# Homebrew
if type brew >/dev/null 2>&1; then
    export HOMEBREW_PREFIX="$(brew --prefix)"
fi

# Qt 5.9
if [ -n "${HOMEBREW_PREFIX}" ]; then
    path=($path "${HOMEBREW_PREFIX}/opt/qt5/bin"(N-/))
fi

# Treefrog
if [ -d "${HOME}/Local/treefrog" ]; then
    export TREEFROG_PREFIX="${HOME}/Local/treefrog"
    path=($path "${TREEFROG_PREFIX}/bin"(N-/))
fi

# Anaconda
if [ -d "${HOMEBREW_PREFIX}/anaconda3" ]; then
    path=($path "${HOMEBREW_PREFIX}/anaconda3/bin")
fi

# Google Cloud SDK
if [ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
    source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi

