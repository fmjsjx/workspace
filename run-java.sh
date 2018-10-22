#!/bin/bash

# check system environment, java8 is required
tpj=`type -p java`

if [[ "$tpj" ]]; then
  _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]]; then
  _java="$JAVA_HOME/bin/java"
else
  echo "Error: java8 is required."
  exit 1
fi

if [[ "$_java" ]]; then
  version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
else
  echo "Error: java8 is required."
  exit 1
fi

if [[ "$version" < "1.8" ]]; then
  echo "Error: java8 is required."
  exit 1
fi

# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`
PRGDIR=`cd ${PRGDIR}/..;pwd`
cd ${PRGDIR}

mkdir -p ${PRG_DIR}/logs

# set conf dir path
if [ -z $CONF_DIR ]; then 
  CONF_DIR="${PRG_DIR}/conf"
fi

LOG_CONF_DIR="${PRG_DIR}/conf"

CP="${LOG_CONF_DIR}"
ls=`ls "${PRG_DIR}/lib"`
for file in $ls; do
  if [ -f "${PRG_DIR}/lib/$file" ] && [[ "$file" =~ .+\.(jar|zip)$ ]]; then
    CP="$CP:lib/$file"
  fi
done

MEM_OPTS="-Xms128M -Xmx128M -XX:MaxDirectMemorySize=128M"

OPTS="-server ${MEM_OPTS}"
OPTS="${OPTS} -verbose:gc -XX:+PrintGCDetails -Xloggc:${PRG_DIR}/logs/gc.log"
OPTS="${OPTS} -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:G1ReservePercent=25"
OPTS="${OPTS} -XX:InitiatingHeapOccupancyPercent=35"
OPTS="${OPTS} -Dfile.encoding=UTF-8"
#OPTS="${OPTS} -Duser.timezone=Asia/Shanghai"
OPTS="${OPTS} -Dsimple.conf.dir=${CONF_DIR}"
OPTS="${OPTS} -cp ${CP}"

ULIMIT_N="100000"

ulimit -n ${ULIMIT_N}

for arg in $*; do
  if [ "$arg" == "--daemon" ]; then
    daemon_mode="true"
  fi
done

if [ "$daemon_mode" == "true" ]; then
  nohup java ${OPTS} xxx.XXX startup >/dev/null 2>&1 &
  echo $! > ${PRG_DIR}/bin/.pid
else
  exec java ${OPTS} xxx.XXX startup
fi
