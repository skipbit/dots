# uses example
#  % startxdocker
#  % docker run -it --rm -e DISPLAY=$DISPLAY_MAC -v /tmp/.X11-unix:/tmp/.X11-unix ubuntu:16.04
#  # apt update && apt install -y x11-apps
#  # xeyes

export DISPLAY_MAC=$(/sbin/ifconfig en0 | grep "inet " | cut -d" " -f2):0

function startxdocker() {
    if type socat >/dev/null 2>&1 && type XQuartz >/dev/null 2>&1; then
        if [ -z "$(ps -ef | grep XQuartz | grep -v grep)" ]; then
            open -a XQuartz
            socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
        fi
    else
        echo "You needs prepare environment by following commands:"
        echo "  % brew install socat"
        echo "  % brew cask install xquartz"
    fi
}

function killxdocker() {
    ps aux | grep XQuartz | grep -v grep | awk '{print "kill", $2}' | sh
    ps aux | grep socat | grep -v grep | awk '{print "kill", $2}' | sh
}

