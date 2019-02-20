
if type brew > /dev/null 2>&1; then
    export HOMEBREW_PREFIX="$(brew --prefix)"

    cppflags=(); ldflags=()
    for p in $(ls ${HOMEBREW_PREFIX}/Cellar); do
        formula="${HOMEBREW_PREFIX}/Library/Taps/homebrew/homebrew-core/Formula/${p}.rb"
        # path, pkg_config_path
        if [ -f "${formula}" ] && grep 'keg_only' "${formula}"  > /dev/null; then
            path=($path "${HOMEBREW_PREFIX}/opt/${p}/bin"(N-/))
        fi
        pkg_config_path=($pkg_config_path "${HOMEBREW_PREFIX}/opt/${p}/lib/pkgconfig"(N-/))
        # cppflags
        if [ -d "${HOMEBREW_PREFIX}/opt/${p}/include" ]; then
            cppflags=(-I"${HOMEBREW_PREFIX}/opt/${p}/include" ${cppflags})
        fi
        # ldflags
        if [ -d "${HOMEBREW_PREFIX}/opt/${p}/lib" ]; then
            ldflags=(-L"${HOMEBREW_PREFIX}/opt/${p}/lib" ${ldflags})
        fi
    done
    export CPPFLAGS="${cppflags}"
    export LDFLAGS="${ldflags}"
fi

