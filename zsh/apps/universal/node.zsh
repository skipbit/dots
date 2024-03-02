
if type fnm > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
    eval "$(fnm completions --shell "zsh")"
elif type volta > /dev/null 2>&1; then
    export VOLTA_HOME="${HOME}/.volta"
    path=($path "${VOLTA_HOME}/bin")
fi
