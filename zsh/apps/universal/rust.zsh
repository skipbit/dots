
if [ -f "${HOME}/.cargo/env" ]; then
  source "${HOME}/.cargo/env"
elif type rustup >/dev/null 2>&1; then
  path=("${HOME}/.cargo/bin"(N-/) $path)
fi
