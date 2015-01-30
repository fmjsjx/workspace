#!/bin/bash

# fix classpath

LOG_CONF_DIR="conf"

CLASSPATH="$CLASSPATH:${LOG_CONF_DIR}"

ls=`ls "${PRG_DIR}/lib"`
for file in $ls; do
  if [ -f "${PRG_DIR}/lib/$file" ] && [[ "$file" =~ .+\.(jar|zip)$ ]]; then
    CLASSPATH="$CLASSPATH:lib/$file"
  fi
done
