
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
    export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"
fi
