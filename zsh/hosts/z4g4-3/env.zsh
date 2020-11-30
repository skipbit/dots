
# pyenv
PYENV_ROOT="${HOME}/.pyenv"
PATH="${PYENV_ROOT}/bin:${PATH}"
#path=("${PYENV_ROOT}/bin" $path)

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

