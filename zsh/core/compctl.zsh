#
# compctl
#

# あらかじめ定義されている補完定義をロード
autoload -U compinit; compinit

# 補完候補にも色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

compctl -g '.*(/) *(/) *(@)' cd chdir dirs pushd

# configure optionを補完
configure_opts(){
	replay=( `./configure --help | awk '/--/{print $1}' | sed -e 's/--//' -e 's/=.*/=/'` )
}
compctl -x 'n[1,=]' -f -- + -P -- -K configure_opts configure

#
#
compctl -k "(`if [ -d /var/db/pkg ]; then /bin/ls -1 /var/db/pkg; fi`)" \
	pkg_delete pkg_info pkg_version

# ユーザー名 グループ名を補完
compctl -k "(`awk -F ':' '{print $1}' /etc/passwd`)" su chown
compctl -k "(`awk -F ':' '{print $1}' /etc/group`)" chgrp

# compctl -l '' nohup exec nice eval time sudo man

# ncftp 関連ファイルをncftpbookmarksで補完
if [ -f $HOME/.ncftp/bookmarks ]; then
	compctl -k "(`awk -F ',' '/^([^NcFTP]|[^Number])/{print $1}' $HOME/.ncftp/bookmarks`)" \
		ncftpls ncftpget ncftpbatch ncftpput ncftpspooler
fi

if [ $UID != 0 ]; then
# PostgreSQL
	if [ -x /usr/local/pgsql/bin/psql ]; then
		compctl -k "(`/usr/local/pgsql/bin/psql -lt | awk '{print $1}'`)" \
			psql dropdb pg_dump vacuumdb
	fi
fi
