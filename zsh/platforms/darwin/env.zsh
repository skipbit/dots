# メモ
#! <http://qiita.com/mattintosh4/items/dc6ca7adf3d2b0c9be96>
#! % xcrun -find gcc
#! % /usr/sbin/sysctl -n user.cs_path

# Developer Tools
if type xcode-select > /dev/null 2>&1; then
	export DEVELOPER_DIR="`xcode-select -print-path`"
	path=($path "${DEVELOPER_DIR}/usr/bin" "${DEVELOPER_DIR}/Tools")
else
	# old-style
	[ -d /Developer/Tools ] && path=($path /Developer/Tools)
fi

# Appendix application
config=(homebrew docker-x11)
for _config in "${config[@]}"; do
    zappload "${_config}"
done

