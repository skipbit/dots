#
# compctl
#

# ���餫�����������Ƥ����䴰��������
autoload -U compinit; compinit

# �䴰����ˤ⿧�դ�
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

compctl -g '.*(/) *(/) *(@)' cd chdir dirs pushd

# configure option���䴰
configure_opts(){
	replay=( `./configure --help | awk '/--/{print $1}' | sed -e 's/--//' -e 's/=.*/=/'` )
}
compctl -x 'n[1,=]' -f -- + -P -- -K configure_opts configure

#
#
compctl -k "(`if [ -d /var/db/pkg ]; then /bin/ls -1 /var/db/pkg; fi`)" \
	pkg_delete pkg_info pkg_version

# �桼����̾ ���롼��̾���䴰
compctl -k "(`awk -F ':' '{print $1}' /etc/passwd`)" su chown
compctl -k "(`awk -F ':' '{print $1}' /etc/group`)" chgrp

# compctl -l '' nohup exec nice eval time sudo man

# ncftp ��Ϣ�ե������ncftpbookmarks���䴰
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
