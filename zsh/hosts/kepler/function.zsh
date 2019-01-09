
function exec_python3_container_cmd() {
    set -o SH_WORD_SPLIT

    cmd="${@:-python3}"
    process="$(docker container ls -q -f "name=python3")"
    if [ -z "${process}" ]; then
        process="$(docker container ls -qa -f "name=python3")"
        if [ -z "${process}" ]; then
            dropbox="$(jq -r .personal.path $HOME/.dropbox/info.json)"
            "${dropbox}/Docker/bin/container-python3.sh"
            docker exec -it "${process}" ${cmd}
        else
            docker start "${process}"
            docker exec -it "${process}" ${cmd}
        fi
    else
        docker exec -it "${process}" ${cmd}
    fi
}

function python3() {
    exec_python3_container_cmd python3 "${@}"
}

function pip3() {
    exec_python3_container_cmd pip3 "${@}"
}

