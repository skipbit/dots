
# n
if type n >/dev/null 2>&1; then
    export N_PREFIX="${HOME}/.n"
    path=("${N_PREFIX}/bin" $path)
fi
