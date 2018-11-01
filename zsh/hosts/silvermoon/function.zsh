
function _mklist() {
    _files -W ~/Downloads/links && return 0;
    return 1;

    #local -a labels
    #labels=( $(find $HOME/Downloads -type f -name '*.link' -exec basename '{}' ';' | sed -e 's/.link$//') )
    #compadd ${labels}

    #local -a _labels
    #_labels=( $(find $HOME/Downloads -type f -name '*.link' -exec basename '{}' ';' | sed -e 's/.link$//') )
    #_describe -t labels "exist labels" _labels
}
compdef _mklist mklist

