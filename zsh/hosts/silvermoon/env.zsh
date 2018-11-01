
# Tomcat
if [ -d "/usr/local/apache-tomcat-6.0.44" ]; then
	export CATALINA_HOME="/usr/local/apache-tomcat-6.0.44"
fi

# Scala
if [ -d "$HOME/Local/scala/bin" ]; then
	export SCALA_HOME="$HOME/Local/scala"
fi

# PostgreSQL
if [ -d "/usr/local/opt/postgresql" ]; then
	export PGDATA="/usr/local/var/postgres"
fi

# nvm
if [ -d "$(brew --prefix nvm)" ]; then
	export NVM_DIR="$HOME/.nvm"
	. $(brew --prefix nvm)/nvm.sh
fi

# caffe
export CAFFE_ROOT=$HOME/Workspace/GitHub/idee-endo/caffe-ssd
path=($path ${CAFFE_ROOT}/build/tools)

