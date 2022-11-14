
# ssh-agent on tmux
LOCAL_SSH_AUTH_SOCK="${HOME}/.ssh/ssh-agent-sock"
if [ -S "${SSH_AUTH_SOCK}" ]; then
    case "${SSH_AUTH_SOCK}" in
        /tmp/*/agent.[0-9]*)
            ln -snf "${SSH_AUTH_SOCK}" "${LOCAL_SSH_AUTH_SOCK}" && export SSH_AUTH_SOCK="${LOCAL_SSH_AUTH_SOCK}"
            ;;
    esac
elif [ -S "${LOCAL_SSH_AUTH_SOCK}" ]; then
    export SSH_AUTH_SOCK="${LOCAL_SSH_AUTH_SOCK}"
else
    : no ssh-agent
fi

