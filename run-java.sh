#!/bin/sh

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

CP="${PRGDIR}/conf"
ls=`ls "${PRGDIR}/lib"`
for file in $ls; do
  if [ -f "${PRGDIR}/lib/$file" ] && [[ "$file" =~ .+\.(jar|zip)$ ]]; then
    CP="$CP:${PRGDIR}/lib/$file"
  fi
done

args=$*

OPTS="-cp ${CP}"

java ${OPTS} com.samsung.demo.App $args
