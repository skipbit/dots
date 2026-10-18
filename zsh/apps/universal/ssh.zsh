
# ssh-agent on tmux
LOCAL_SSH_AUTH_SOCK="${HOME}/.ssh/ssh-agent-sock"

if [ -n "${SSH_AUTH_SOCK:-}" ] &&
   [ "${SSH_AUTH_SOCK}" != "${LOCAL_SSH_AUTH_SOCK}" ] &&
   [ -S "${SSH_AUTH_SOCK}" ]; then
    ln -snf "${SSH_AUTH_SOCK}" "${LOCAL_SSH_AUTH_SOCK}" &&
        export SSH_AUTH_SOCK="${LOCAL_SSH_AUTH_SOCK}"
elif [ -S "${LOCAL_SSH_AUTH_SOCK}" ]; then
    export SSH_AUTH_SOCK="${LOCAL_SSH_AUTH_SOCK}"
else
    : no ssh-agent
fi

if [ -S "${SSH_AUTH_SOCK:-}" ]; then
    mkdir -p "${HOME}/.ssh/agent" && chmod 700 "${HOME}/.ssh/agent"
    ln -f "$(readlink -f "${SSH_AUTH_SOCK}")" "${HOME}/.ssh/agent/sock" 2>/dev/null
fi
