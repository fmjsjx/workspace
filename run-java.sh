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

CP="${PRGDIR}/conf"
ls=`ls "${PRGDIR}/lib"`
for file in $ls; do
  if [ -f "${PRGDIR}/lib/$file" ] && [[ "$file" =~ .+\.(jar|zip)$ ]]; then
    CP="$CP:${PRGDIR}/lib/$file"
  fi
done

args=$*

OPTS="-cp ${CP}"

nohup java -server ${OPTS} com.xxx.XXX $args >/dev/null 2>&1 &
