
# Go
if type go >/dev/null 2>&1; then
    export GOPATH=$HOME/Library/Google/Go
    path=($path "${GOPATH}/bin"(N-/) "$(go env GOROOT)/bin"(N-/))
fi

